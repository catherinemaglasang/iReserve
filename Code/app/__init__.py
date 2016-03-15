# app/__init__.py

from flask import Flask, request, jsonify, session
from flask.ext.bcrypt import Bcrypt
from app.config import BaseConfig
import sys, os, flask, json
from models import DBconn, spcall
from flask.ext.cors import CORS

# config

app = Flask(__name__)
app.config.from_object(BaseConfig)
CORS(app)


bcrypt = Bcrypt(app)


# routes

@app.route('/')
def index():
    return app.send_static_file('index.html')


@app.route('/api/register', methods=['POST'])
def register():
    req = request.json

    email = req['email']
    password = req['password']
    fname = req['fname']
    lname = req['lname']
    contact = str(req['contact'])
    address = req['address']
    postal = str(req['postal'])
    gender = int(req['gender'])
    bday = req['birthdate']

    res = spcall("newcustomer", (email, password, fname, lname, contact, address, postal, gender, bday), True)


    if 'Error' in res[0][0]:
        status = 'this user is already registered'
    else:
        status = 'success'

    return jsonify({'result': status})


@app.route('/api/login', methods=['POST'])
def login():
    json_data = request.json

    res = spcall("getcustomer_id", (str(json_data['email'])), True)
    if res and bcrypt.check_password_hash(str(res[1]), str(json_data['password'])):
        session['logged_in'] = True
        status = True
    else:
        status = False
    return jsonify({'result': status})


@app.route('/api/logout')
def logout():
    session.pop('logged_in', None)
    return jsonify({'result': 'success'})


@app.route('/api/status')
def status():
    if session.get('logged_in'):
        if session['logged_in']:
            return jsonify({'status': True})
    else:
        return jsonify({'status': False})
