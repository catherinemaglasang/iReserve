from app import app
import os
from flask import Flask, jsonify, url_for, render_template, request
from flask.ext.cors import CORS
import flask
import json
import sys
from flask.ext.restful.utils.cors import crossdomain
from flask_httpauth import HTTPBasicAuth
from models import *

CORS(app)


def spcall(qry, param, commit=False):
    try:
        dbo = DBconn()
        cursor = dbo.getcursor()
        cursor.callproc(qry, param)
        res = cursor.fetchall()
        if commit:
            dbo.dbcommit()
        return res
    except:
        res = [("Error: " + str(sys.exc_info()[0]) + " " + str(sys.exc_info()[1]),)]
    return res


@app.route("/")
def index():
    return render_template('index.html')

@app.route("/home")
def home():
    return render_template('home.html')

@app.route('/api/register', methods=['POST'])
def register():
    req = request.json

    res = spcall("newcustomer", (req['email'], req['password'], req['fname'], req['lname'],
                                 req['contact'], req['address'], req['postal'], req['gender'],
                                 req['bday']), True)

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

    return jsonify({'status': 'ok', 'message': res[0][0]})


ROOMS = {}
@app.route('/api/room/', methods=['POST'])
def add_room():

    res = spcall("newroom", (request.json['room_number'], request.json['cost'],request.json['room_type'], request.json['hotel_id']))

    if len(res) == 0:
        return "Query error - Adding room"
    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

    return jsonify({'status': 'ok', 'message': res[0][0]})



@app.route('/api/room/<id>/', methods=['GET'])
def get_roomid(id):

    res = spcall('getid_room', (id))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = res[0]
    
    return jsonify({'room_number' : str(recs[0]), 'cost': str(recs[1]), 'room_type': str(recs[2])})


@app.route('/api/room/', methods=['GET'])
def get_rooms():

    res = spcall('getroom', ())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
        recs.append({"id": int(r[0]), "room_number": r[1], "room_type": str(r[2]), "cost": r[4]})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})