from lettuce import step, world, before
from nose.tools import assert_equals
from app import app
from app.views import *
import json



@before.all
def before_all():
    world.app = app.test_client()


@step(u'Given some rooms are in the system')
def given_some_rooms_are_in_the_system(step):
	ROOMS.update({'1': {'room_number': '209', 'cost': 3000, 'room_type': 'one bed'}})
   

@step(u'When I retrieve the room with an id number \'(.*)\'')
def when_i_retrieve_the_room_number(step,id):
    world.response = world.app.get('/api/room/{}/'.format(id))

@step(u'Then I should get a \'(.*)\' response')
def then_i_should_get_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And the following room details are returned:')
def and_the_following_room_details(step):
    assert_equals(step.hashes, [json.loads(world.response.data)])








