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
    return render_template('test.html')

@app.route("/home")
def home():
    return render_template('home.html')

@app.route('/api/register', methods=['POST'])
def register():


    # get all the input values for client side
    value_one = request.form.get('first')
    value_two = request.form.get('second')
    value_three = request.form.get('third')
    value_four = request.form.get('fourth')
    value_five = int( request.form.get('fifth') )
    value_six = request.form.get('sixth')
    value_seven = request.form.get('seventh')
    value_eight = request.form.get('eighth')
    value_nine = request.form.get('ninth')

    # store all the collected values(from client side) to database using stored proc
    res = spcall("newcustomer", (value_one, value_two, value_three, value_four,
                                 value_five, value_six, value_seven, value_eight,
                                 value_nine), True)

    # print values for tracing purpose
    print value_one
    print value_two
    print value_three
    print value_four
    print int(value_five)
    print value_six
    print value_seven
    print value_eight
    print value_nine
    # printing the res will show if successful
    print res

    # returning a json (this will call the client side again(ajax chuchu)
    return jsonify({'status': 'ok',})

@app.route('/api/hotel/', methods=['GET'])
def get_all_hotels():
    res = spcall('gethotel', (), True)

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0] [0]})

    recs = []
    for r in res:
        recs.append({"id_hotel": str(r[0]), "hotel_name": str(r[1]), "description": str(r[2]), "email_address": str(r[3]),
                    "address": str(r[4]), "contact_number": str(r[5]),"google_map": str(r[6]), "no_of_restaurant": str(r[7]),
                    "no_of_rooms": str(r[8]), "extra": str(r[9]), "is_active": str(r[10])})
        
        return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/api/hotel/<id_hotel>/', methods=['GET'])
def gethotel(id_hotel):
    req = request.json
    res = spcall('gethotel', (id_hotel), True)

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})
       
    rec = res[0]
    return jsonify({'id_hotel': str(id_hotel), "hotel_name": str(rec[0]), "description": str(rec[1]), "email_address": str(rec[2]),
                    "address": str(rec[3]), "contact_number": str(rec[4]),"google_map": str(rec[5]), "no_of_restaurant": str(rec[6]),
                    "no_of_rooms": str(rec[7]), "extra": str(rec[8]), "is_active": str(rec[9])})

@app.route('/api/hotel', methods=['POST'])
def newhotel():
    req = request.json
    id_hotel = req['id_hotel']
    hotel_name = req['hotel_name']
    description = req['description']
    email_address = req['email_address']
    address = req['address']
    contact_number = req['contact_number']
    google_map = req['google_map']
    no_of_restaurant = req['no_of_restaurant']
    no_of_rooms = req['no_of_rooms']
    extra = req['extra']
    res = spcall('newhotel', (id_hotel, hotel_name, description, email_address, address, contact_number, google_map, no_of_restaurant,
                               no_of_rooms, extra), True)

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})
    return jsonify({'status': 'ok', 'message': res[0][0]})