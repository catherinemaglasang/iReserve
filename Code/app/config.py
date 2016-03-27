# project/config.py

import os
import paypalrestsdk
import braintree

basedir = os.path.abspath(os.path.dirname(__file__))


class BaseConfig(object):
    SECRET_KEY = 'EERwyDyEfWWO4NLFAqs8m4UZxKhZvMOsgeKqi1G0jgyREwE4LuZLC_g677uCJXcHUP7013FU65yAGoHM'
    DEBUG = True
    BCRYPT_LOG_ROUNDS = 13
    paypalrestsdk.configure({
        'mode': 'sandbox',
        'client_id': 'ARoXM7uP0pMV6szI-VGjjmBFODA98t2c2c0mcTlMorOFXC2fFCaD_KLYdvD0WQMkoNrqh83J6jPlMTs4',
        'client_secret': 'EKnb0B6WP7Km-X47iHJx6n2xXfbb5QxlaUsuxHyNh1a2J8RfrBAaKoSNrFbHoQ1tR3giqQlqRKqcOrP-'
    })

    braintree.Configuration.configure(braintree.Environment.Sandbox,
                                      merchant_id="2rqw2449w24rmtvm",
                                      public_key="mbshnd4nv9236pr9",
                                      private_key="b667f52749d1dc00cb56de3622faa868")