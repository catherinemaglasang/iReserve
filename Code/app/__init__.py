# app/__init__.py

from flask import Flask, request, jsonify, session, make_response
from flask.ext.bcrypt import Bcrypt
from app.config import BaseConfig
import sys, os, flask, json
from itertools import chain
from models import DBconn, spcall
from flask.ext.cors import CORS

# config

app = Flask(__name__)
app.config.from_object(BaseConfig)
CORS(app)

bcrypt = Bcrypt(app)


# Paypal

def ordered_storage(f):
    import werkzeug.datastructures
    import flask
    def decorator(*args, **kwargs):
        flask.request.parameter_storage_class = werkzeug.datastructures.ImmutableOrderedMultiDict
        return f(*args, **kwargs)

    return decorator


# routes

@app.route('/')
def index():
    return app.send_static_file('index.html')


@app.route('/api/v1.0/hotel_personnel/register', methods=['POST'])
def register():
    req = request.json

    password = req['password']
    fname = req['fname']
    lname = req['lname']
    mname = req['mname']

    res = spcall("newHotel_Personnel", (fname, mname, lname, password, 1), True)

    if 'Error' in res[0][0]:
        status = 'this user is already registered'
    else:
        status = 'success'

    return jsonify({'result': status})


@app.route('/api/v1.0/hotel_personnel/login', methods=['POST'])
def login():
    json_data = request.json

    res = spcall("getid_personnel", (json_data['lname']), True)
    if res and 'gwapa' == json_data['password']:
        session['logged_in'] = True
        status = True
    else:
        status = False
    return jsonify({'result': status})


@app.route('/api/v1.0/hotel_personnel/logout')
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


@app.route('/webhooks/paypal', methods=['POST'])
@ordered_storage
def paypal_webhook():
    # probably should have a sanity check here on the size of the form data to guard against DoS attacks
    verify_args = chain(request.form.iteritems(), IPN_VERIFY_EXTRA_PARAMS)
    verify_string = '&'.join(('%s=%s' % (param, value) for param, value in verify_args))
    with closing(urlopen(IPN_URLSTRING, data=verify_string)) as paypal_verify_request:
        response_string = paypal_verify_request.read()
        if response_string != 'VERIFIED':
            raise ValueError('Did not receive expected IPN confirmation from PayPal')
    return make_response('')


@app.route('/api/room/', methods=['POST'])
def add_room():
    req = json.loads(request.data)

    res = spcall("newroom", (
        req['room_number'],
        req['cost'],
        req['room_type'], 
        req['hotel_id']
        ))


    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

    return jsonify({'status': 'ok', 'message': res[0][0]})


@app.route('/api/room/<id>/', methods=['GET'])
def get_roomid(id):

    res = spcall('getid_room', [id])

    if not res:
        return jsonify({'status': 'error', 'message': 'Results Not Found'}),404

    recs = res[0]
    
    return jsonify({'room_number' : str(recs[0]), 'cost': str(recs[1]), 'room_type': str(recs[2])})


@app.route('/api/room/', methods=['GET'])
def get_rooms():

    res = spcall('getroom', ())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
        recs.append({
         "id": int(r[0]),
         "room_number": r[1],
         "cost": (r[2]),
         "room_type": str(r[3])
         })

    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})