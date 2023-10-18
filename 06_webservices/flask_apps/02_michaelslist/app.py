# A web app that allows you to create, read, update, and delete posts,
# which are maintained in memory.

from flask import Flask, request, abort
import json

app = Flask(__name__)

POSTS = {} # in-memory database of post_id -> Post
NEXT_POST_ID = 10000 # used to generate unique post IDs

# A Post object represents a single post.    
class Post:
    def __init__(self, title, description, author):
        '''Create a new Post object with a unique id and the given content.'''
        global POSTS, NEXT_POST_ID

        self.id = NEXT_POST_ID
        NEXT_POST_ID += 1

        self.title = title
        self.description = description
        self.author = author


@app.route('/', methods=['GET'])
def index():
    template = '''<div style="width: 200px; 
                              margin: 10px auto;
                              padding: 10px;
                              border: 1px solid black;">
                    <h2>{title}</h2>
                    <p>{description}<p>
                    <p>- {author}<p>
                  </div>'''
    return ('<h1 style="text-align:center">Michael\'s List</h1>'
            + '\n'.join([template.format(**p.__dict__)
                         for p in POSTS.values()]))


@app.route('/posts', methods=['GET', 'POST'])
def posts():
    if request.method == 'GET':
        return json.dumps([{ 
            'id':          p.id,
            'title':       p.title,
            'description': p.description,
            'author':      p.author
        } for p in POSTS.values()])
    else:
        data = request.get_json()
        post = Post(data['title'], data['description'], data['author'])
        POSTS[post.id] = post
        return json.dumps({'id': post.id})


@app.route('/post/<int:post_id>', methods=['GET', 'PUT', 'DELETE'])
def post(post_id):
    if post_id not in POSTS:
        abort(404)

    if request.method == 'GET':
        post = POSTS[post_id]
        return json.dumps({
            'title':       post.title, 
            'description': post.description,
            'author':      post.author
        })
    elif request.method == 'PUT':
        post = POSTS[post_id]
        data = request.get_json()
        for field in 'title', 'description', 'author':
            if field in data:
                setattr(post, field, data[field])
        return json.dumps({'id': post.id})
    else:
        del POSTS[post_id]
        return json.dumps({'id': post_id})



HOSTNAME='0.0.0.0'
PORT=5001

if __name__ == '__main__':
    app.run(host=HOSTNAME, port=PORT, debug=True)
