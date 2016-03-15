# project/config.py

import os
basedir = os.path.abspath(os.path.dirname(__file__))


class BaseConfig(object):
    SECRET_KEY = 'ASk293dSJSL12ncxhsS'
    DEBUG = True
    BCRYPT_LOG_ROUNDS = 13