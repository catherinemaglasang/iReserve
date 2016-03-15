from sqlalchemy import create_engine
import os
import sys


class DBconn:
    def __init__(self):
<<<<<<< HEAD
        engine = create_engine("postgresql://postgres:james61118@localhost:5432/iReserve", echo=False)
=======
        engine = create_engine('postgresql://postgres:asdasd@localhost:5432/iReserve', echo=False)
>>>>>>> d8de2fae64e506267332c051901f495468d0f76f
        self.conn = engine.connect()
        self.trans = self.conn.begin()

    def getcursor(self):
        cursor = self.conn.connection.cursor()
        return cursor

    def dbcommit(self):
        self.trans.commit()


# Stored Procedures Call
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
