from app import app, db
# from flask_restful import reqparse, abort, Api, Resource
from app.models import User, Role
from flask.ext.security import Security, SQLAlchemyUserDatastore, \
    UserMixin, RoleMixin, login_required
#Setup Flask-Security
user_datastore = SQLAlchemyUserDatastore(db, User, Role)
security = Security(app, user_datastore)

# api = Api(app)


@app.route("/")
def index():
    return "Hello World"