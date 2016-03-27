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


#Retrieving room details

@step(u'Given a room exist with an id number "1"')
def given_some_rooms_are_in_the_system(step):
	world.browser = TestApp(app)
	world.room = world.app.get('/api/room/1/')
	world.resp = json.loads(world.room.data)

@step(u'When I retrieve the room with an id number \'(.*)\'')
def when_i_retrieve_the_room_number(step,id):
    world.response = world.app.get('/api/room/{}/'.format(id))

@step(u'Then I should get a \'(.*)\' response')
def then_i_should_get_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))

    
@step(u'And the following details are returned:')
def details_returned(step):
	world.info = step.hashes[0]
	assert_equals(world.info, json.loads(world.response.data))


#Retrieving a non-existent roo

#Updating room details

@step(u'Given a room with an id number "3" with the following details:')
def given_the_following_details(step):
	world.details3 = step.hashes[0]

@step(u'When i update the room details into the following:')
def change_details(step):
	world.details4 = step.hashes[0]
	world.browser = TestApp(app)
	world.room_url = '/api/room/'
	world.response = world.app.put(world.room_url, data = json.dumps(world.details4))


@step(u'Then i will get a \'([^\']*)\' response')
def then_i_should_get_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And it should have a field "status" containing "success"')
def status_success(step):
	world.resp = json.loads(world.response.data)
	assert_equals(world.resp['status'], "success")


@step(u'Given a room with an id number "5" doesnt exist')
def room_doesnt_exist(step):
	assert True

@step(u'When i retrieve a room with an id number \'(.*)\'')
def retrieve_room(step,id):
	 world.response = world.app.get('/api/room/{}/'.format(id))

@step(u'Then it should have a field "status" containing "error"')
def response_status(step):
	world.resp = json.loads(world.response.data)
	assert_equals(world.resp['status'], "error")

@step(u'And it should have a field "message" containing "Results Not Found"')
def response_message(step):
	world.resp = json.loads(world.response.data)
	assert_equals(world.resp['message'], "Results Not Found")


#Updating room details

@step(u'Given a room with an id number "3" with the following details:')
def given_the_following_details(step):
	world.details3 = step.hashes[0]

@step(u'When i update the room details into the following:')
def change_details(step):
	world.details4 = step.hashes[0]
	world.browser = TestApp(app)
	world.room_url = '/api/room/'
	world.response = world.app.put(world.room_url, data = json.dumps(world.details4))


@step(u'Then i will get a \'([^\']*)\' response')
def then_i_should_get_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And it should have a field "status" containing "success"')
def status_success(step):
	world.resp = json.loads(world.response.data)
	assert_equals(world.resp['status'], "success")

