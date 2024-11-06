# A web app that allows you to create, read, update, and delete posts,
# which are maintained in memory.

from flask import Flask, request, abort, jsonify

app = Flask(__name__)


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


POSTS: dict[int, Post] = {} # in-memory database of post_id -> Post
NEXT_POST_ID = 10000 # used to generate unique post IDs


@app.route('/')
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


@app.route('/posts')
def list_posts():
    return jsonify([{ 
        'id':          p.id,
        'title':       p.title,
        'description': p.description,
        'author':      p.author
    } for p in POSTS.values()])


@app.route('/posts', methods=['POST'])
def create_post():
    data = request.get_json()
    post = Post(data['title'], data['description'], data['author'])
    POSTS[post.id] = post
    return jsonify({'id': post.id})


@app.route('/posts/<int:post_id>')
def get_post(post_id):
    if post_id not in POSTS:
        abort(404)

    post = POSTS[post_id]
    return jsonify({
        'title':       post.title, 
        'description': post.description,
        'author':      post.author
    })


@app.route('/posts/<int:post_id>', methods=['PUT', 'DELETE'])
def update_post(post_id):
    if post_id not in POSTS:
        abort(404)

    if request.method == 'PUT':
        post = POSTS[post_id]
        data = request.get_json()
        for field in 'title', 'description', 'author':
            if field in data:
                setattr(post, field, data[field])
        return jsonify({'message': 'Post updated successfully'})
    else:
        del POSTS[post_id]
        return jsonify({'message': 'Post deleted successfully'})


@app.errorhandler(404)
def not_found(error):
    return jsonify({'error': 'Not Found'}), 404


HOSTNAME='0.0.0.0'
PORT=5001

if __name__ == '__main__':
    app.run(host=HOSTNAME, port=PORT, debug=True)
