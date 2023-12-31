# A web app that allows users to create, read, and delete posts.
# Users must register and log in to create posts, and can only 
# delete posts that they created. User and post information is
# stored in a SQLite database. Session management is handled by
# the Flask-Session extension.

from flask import Flask, request, abort, session, jsonify
from flask_session import Session
from functools import wraps
import sqlite3
import json


app = Flask(__name__)

# Session configuration
app.config['SESSION_TYPE'] = 'filesystem'  # Use filesystem-based session
Session(app)


# Initialize the SQLite database
db = sqlite3.connect('bulletin_board.db', check_same_thread=False)
cursor = db.cursor()
cursor.execute('''
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
)
''')
cursor.execute('''
CREATE TABLE IF NOT EXISTS posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    content TEXT,
    user_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users (id)
)
''')
db.commit()


def login_required(func):
    @wraps(func)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            abort(401)
        return func(*args, **kwargs)
    return decorated_function


@app.route('/posts')
def list_posts():
    cursor.execute('''
        SELECT posts.id, posts.title, posts.content, users.username
        FROM posts
        INNER JOIN users ON posts.user_id = users.id
    ''')
    posts = cursor.fetchall()
    return jsonify([{ "id": p[0], "title": p[1], 
                      "content": p[2], "author": p[3] }
                    for p in posts ])


@app.route('/posts', methods=['POST'])
@login_required
def add_post():
    data = request.get_json()
    title = data.get('title')
    content = data.get('content')

    user_id = session['user_id']
    cursor.execute('INSERT INTO posts (title,content,user_id) VALUES (?,?,?)', 
                   (title, content, user_id))
    db.commit()
    return jsonify({ 'message': 'Post added successfully',
                     "id": cursor.lastrowid })


@app.route('/posts/<int:id>', methods=['DELETE'])
@login_required
def delete_post(id):
    # check to make sure that the post creator is the one deleting it
    user_id = session['user_id']

    cursor.execute('SELECT * FROM posts WHERE id = ?', (id,))
    post = cursor.fetchone()

    if not post:
        abort(404)

    if post[3] != user_id:
        abort(403)

    cursor.execute('DELETE FROM posts WHERE id = ?', (id,))
    db.commit()
    return json.dumps({'success': True})


@app.route('/register', methods=['POST'])
def register():
    if request.method == 'POST':
        data = request.get_json()
        username = data.get('username')
        password = data.get('password')

        try:
            cursor.execute('INSERT INTO users (username,password) VALUES (?,?)',
                            (username, password))
            db.commit()
            user_id = cursor.lastrowid
            session['user_id'] = user_id
            return jsonify({'message': f'User created successfully'})
        except sqlite3.Error as e:
            abort(409)
    

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    cursor.execute('SELECT * FROM users WHERE username=? AND password=?', 
                    (username, password))
    user = cursor.fetchone()

    if user:
        # Store user information in the session
        session['user_id'] = user[0]
        return jsonify({'message': 'Login successful'})
    else:
        abort(401)


@app.route('/users')
def list_users():
    cursor.execute('SELECT * FROM users')
    users = cursor.fetchall()
    return jsonify([{ "id": u[0], "username": u[1] } for u in users ])


@app.route('/users/<username>', methods=['DELETE'])
@login_required
def delete_user(username):
    # check to make sure that the user is deleting their own account
    user_id = session['user_id']

    print(username)
    cursor.execute('SELECT * FROM users WHERE username = ?', (username,))
    user = cursor.fetchone()

    if not user:
        abort(404)

    if user[0] != user_id:
        abort(403)

    # delete all posts belonging to this user
    cursor.execute('DELETE FROM posts WHERE user_id = ?', (user_id,))

    # delete the user
    cursor.execute('DELETE FROM users WHERE username = ?', (username,))
    db.commit()

    session.pop('user_id', None)

    return json.dumps({'success': True})


@app.route('/logout')
def logout():
    session.pop('user_id', None)
    return jsonify({'message': 'Logout successful'})


@app.errorhandler(401)
def unauthorized(error):
    return jsonify({'error': 'Unauthorized access'}), 401


@app.errorhandler(403)
def forbidden(error):
    return jsonify({'error': 'Forbidden'}), 403


@app.errorhandler(404)
def not_found(error):
    return jsonify({'error': 'Not Found'}), 404


@app.errorhandler(409)
def not_found(error):
    return jsonify({'error': 'Conflict'}), 404


HOSTNAME='0.0.0.0'
PORT=5001

if __name__ == '__main__':
    app.run(host=HOSTNAME, port=PORT, debug=True)
