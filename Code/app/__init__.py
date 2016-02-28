from flask import Flask

app = Flask(__name__)

app.secret_key = '23jDSJ32lzcxcwsSDWJK'
#app.CSRF_ENABLED = True

from app import views, models
