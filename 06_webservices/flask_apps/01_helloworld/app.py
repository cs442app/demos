# A simple web app that says hello in different languages, and
# allows you to add greetings in new languages.

from flask import Flask, request
import random

app = Flask(__name__)

hellos = {
    'cn': '你好，世界！',
    'en': 'Hello, World!',
    'es': '¡Hola Mundo!',
    'th': 'สวัสดีชาวโลก!',
}

@app.route('/')
def index():
    return random.choice(list(hellos.values()))


@app.route('/<lang>', methods=['GET', 'PUT'])
def other_hellos(lang):
    if request.method == 'GET':
        return hellos.get(lang, 'Hello, World!')
    else:
        hellos[lang] = request.get_data().decode('utf-8')
        return 'Success', 200
        

HOSTNAME='0.0.0.0'
PORT=5001

if __name__ == '__main__':
    app.run(host=HOSTNAME, port=PORT, debug=True)
