from lettuce import step, world, before
from nose.tools import assert_equals
from webtest import *
from app import app
from app.__init__ import *
import json



@before.all
def before_all():
    world.app = app.test_client()


#Adding a room

@step(u'Given I input the following room details:')
def given_i_input_the_following_room_details(step):
	world.details1 = step.hashes[0]

@step(u'When I click the add button')
def when_i_click_add_button(step):
	world.browser = TestApp(app)
	world.room_url = '/api/room/'
	world.response = world.app.post(world.room_url, data = json.dumps(world.details1))

@step(u'Then the room is added in the system')
def then_i_should_get_response(step):
	assert_equals(world.response.status_code, 200)

@step(u'And it should have a field "message" containing "OK"')
def message_field(step):
	world.rsp = json.loads(world.response.data)
	assert_equals(world.rsp['message'], "OK")
    

@step(u'And it should have a field "status" containing "ok"')
def message_field(step):
	world.rsp = json.loads(world.response.data)
	assert_equals(world.rsp['status'], "ok")








