#!/usr/bin/env python3
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return "<h1>Hello World</h1>"

@app.route('/home')
def index2():
    return 'My Home'

if  __name__ == '__main__':
    app.run(host='127.0.0.1',port=80,debug=True)
