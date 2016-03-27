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


# Create Feedback

@step(u'Given I am in the hotel feedback form with details:')
def given_i_am_in_the_hotel_feedback_form_with_details(step):
    world.feedback = step.hashes[0]


@step(u'When I submit the feedback form')
def when_i_submit_the_feedback_form(step):
    world.browser = TestApp(app)
    world.response = world.browser.post('/api/v1.0/feedback/', world.feedback)


@step(u'Then I should get a \'([^\']*)\' response')
def then_i_should_get_a_group1_response(step, group1):
    assert_equals(world.response.status_code, int(group1))


@step(u'And a message \'([^\']*)\' are returned')
def and_a_message_group1_are_returned(step, message):
    resp = json.loads(world.response.body)
    assert_equal(resp['message'], message)


#View Feedback

@step(u'Given I am in the hotel\'s page with id:')
def given_i_am_in_the_hotel_s_page_with_id(step):
    world.hotel_id = step.hashes[0]['hotel_id']


@step(u'When I pressed view all feedback')
def when_i_pressed_view_all_feedback(step):
    world.browser = TestApp(app)
    world.response = world.browser.get('/api/v1.0/feedback/{}/'.format(world.hotel_id))


@step(u'And it returns all hotel\'s feedback:')
def and_it_shows_all_hotel_s_feedback(step):
    resp = json.loads(world.response.body)

    for column in step.hashes:
        world.comment = column['comment']
        world.created_date = column['created_date']
        world.id = column['id']
        world.name = column['name']

    col = [[{'comment': str(world.comment), 'created_date': str(world.created_date), 'id': int(world.id),
             'name': str(world.name)}]]

    assert_equals(col, [resp['entries']])


#Search


@step(u'Given I filled up search box with keyword \'([^\']*)\'')
def given_i_filled_up_search_box_with_keyword_group1(step, group1):
    world.search_location = group1


@step(u'When I submit the keyword')
def when_i_submit_the_keyword(step):
    world.browser = TestApp(app)
    world.response = world.browser.get('/api/v1.0/search/{}/'.format(world.search_location))


@step(u'Then I should get a \'([^\']*)\' response')
def then_i_should_get_a_group1_response(step, group1):
    assert_equals(world.response.status_code, int(group1))


@step(u'And it should return this following hotel with its detail:')
def and_it_should_return_this_following_hotel_with_its_detail(step):
    resp = json.loads(world.response.body)

    for column in step.hashes:
        world.id_hotel = column['id_hotel']
        world.hotel_name = column['hotel_name']
        world.description = column['description']
        world.email_address = column['email_address']
        world.address = column['address']
        world.contact_number = column['contact_number']
        world.no_of_restaurant = int(column['no_of_restaurant'])
        world.no_of_rooms = int(column['no_of_rooms'])
        world.extra = column['extra']

    col = [[{'id_hotel': int(world.id_hotel), 'hotel_name': str(world.hotel_name), 'description': str(world.description),
             'email_address': str(world.email_address), 'address': str(world.address),
             'contact_number': str(world.contact_number), 'no_of_restaurant': int(world.no_of_restaurant),
             'no_of_rooms': int(world.no_of_rooms), 'extra': str(world.extra)}]]

    assert_equals(col, [resp['entries']])
