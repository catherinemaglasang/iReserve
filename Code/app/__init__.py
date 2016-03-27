# app/__init__.py

from flask import Flask, request, jsonify, session, make_response
from app.config import BaseConfig
import sys, os, flask, json
from models import DBconn, spcall
from flask.ext.cors import CORS

# config

app = Flask(__name__)
app.config.from_object(BaseConfig)
CORS(app)


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


@app.route('/api/room/', methods=['PUT'])
def updateroom():
    jsn = json.loads(request.data)

    id_room = jsn.get('id_room','')
    room_number = jsn.get('room_number', '')
    cost = jsn.get('cost', '')
    room_type = jsn.get('room_type', '')

    res = spcall('updateroom', (
        id_room,
        room_number,
        cost,
        room_type),True)

    return jsonify({"status": "success"})


    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})



@app.route('/api/v1.0/feedback/', methods=['POST'])
def feedback():
    """             Creating a Feedback                   """

    res = spcall("newfeedback", (request.form['name'], request.form['comment'], request.form['hotel_id']))

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

    return jsonify({'status': 'ok', 'message': res[0][0]})


@app.route('/api/v1.0/feedback/<id>/', methods=['GET'])
def view_feedback(id):
    
    """             Viewing Specific Feedback                """
    
    res = spcall("getfeedback", id, True)

    recs = []
    for r in res:
        recs.append({"id": int(r[0]), "name": r[1], "comment": r[2], "created_date": r[3]})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})


@app.route('/api/v1.0/search/<location>/', methods=['GET'])
def search(location):
    """             Searching a hotel through its location                   """

    res = spcall("location_search", [location], True)

    recs = []
    for r in res:
        recs.append({"id_hotel": int(r[0]), "hotel_name": r[1], "description": r[2], "email_address": r[3],
                     "address": r[4], "contact_number": r[5], "no_of_restaurant": int(r[6]), "no_of_rooms": int(r[7]),
                     "extra": r[8]})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})
