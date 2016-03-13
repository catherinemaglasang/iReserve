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
