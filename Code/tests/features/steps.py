from lettuce import step, world, before
from nose.tools import assert_equals
from app import app
from app.views import *
import json




@before.all
def before_all():
    world.app = app.test_client()

@step(u'I have input the needed information as follows:')
def and_the_following_information(step):
	spcall('newcustomer', ('yan01@gmail.com', 'demeter3616' ,'yan','corpuz', '0906', 'lugait ','900', 1 ,'1/10/96'))
	
		

@step(u'I click the done button')
def i_click_the_done_button(step):
	world.response = world.app.get('api/register')


@step(u'the information is saved in the database')
def information_saved(step):
	assert_equals(step.hashes, [json.loads(world.response.data)])
