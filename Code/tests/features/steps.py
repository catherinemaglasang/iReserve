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


#Adding an existing room

@step(u'Given I input the following room details:')
def given_i_input_the_following_room_details(step):
	world.details2 = step.hashes[0]

@step(u'When I click the add button')
def when_i_click_add_button(step):
	world.browser = TestApp(app)
	world.room_url = '/api/room/'
	world.response = world.app.post(world.room_url, data = json.dumps(world.details2))

@step(u'Then i should get a "message" containing "ID EXISTED"')
def message_field(step):
	world.rsp = json.loads(world.response.data)
	assert_equals(world.rsp['message'], "ID EXISTED")


#Adding a room that has the field room_number empty

@step(u'Given I input the following room details:')
def input_room_details(step):
	world.infos = step.hashes[0]


@step(u'When i click the add button')
def click_button(step):
	world.browser = TestApp(app)
	world.room_url = '/api/room/'
	world.response = world.app.post(world.room_url, data = json.dumps(world.infos))

@step(u'Then i should \'([^\']*)\' response')
def status_code_response(step, expected_status_code):
	assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And a message "error" are returned')
def response_message(step):
	world.resp = json.loads(world.response.data)
	assert_equals(world.resp['message'], "error")


#Adding a room that has the field room_type empty

@step(u'Given I input the following room details:')
def input_room_details(step):
	world.infos = step.hashes[0]


@step(u'When i click the add button')
def click_button(step):
	world.browser = TestApp(app)
	world.room_url = '/api/room/'
	world.response = world.app.post(world.room_url, data = json.dumps(world.infos))

@step(u'Then i should \'([^\']*)\' response')
def status_code_response(step, expected_status_code):
	assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And a message "error" are returned')
def response_message(step):
	world.resp = json.loads(world.response.data)
	assert_equals(world.resp['message'], "error")


# Adding a room that has the field room_number and room_type empty

@step(u'Given I input the following room details:')
def input_room_details(step):
	world.infos = step.hashes[0]


@step(u'When i click the add button')
def click_button(step):
	world.browser = TestApp(app)
	world.room_url = '/api/room/'
	world.response = world.app.post(world.room_url, data = json.dumps(world.infos))

@step(u'Then i should \'([^\']*)\' response')
def status_code_response(step, expected_status_code):
	assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And a message "error" are returned')
def response_message(step):
	world.resp = json.loads(world.response.data)
	assert_equals(world.resp['message'], "error")





