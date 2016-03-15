from sqlalchemy import create_engine
import os

class DBconn:
    def __init__(self):
        engine = create_engine("postgresql://postgres:james61118@localhost:5432/iReserve", echo=False)
        self.conn = engine.connect()
        self.trans = self.conn.begin()

    def getcursor(self):
        cursor = self.conn.connection.cursor()
        return cursor

    def dbcommit(self):
        self.trans.commit()