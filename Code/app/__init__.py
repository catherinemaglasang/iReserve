from flask import Flask

app = Flask(__name__)

# api = Api(app)
#Include config from config.py
app.config['SQLALCHEMY_DATABASE_URI']= 'postgresql://postgres:marj121596@localhost/flask'
app.secret_key = '23jDSJ32lzcxcwsSDWJK'
#app.CSRF_ENABLED = True

from app import views, models
