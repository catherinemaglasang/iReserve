import json
from lettuce import step, world, before
from nose.tools import assert_equals
from app.views import HOTELS

@before.all
def before_all():
    world.app = app.test_client()


@step(u'some hotels are in the system')
def given_some_hotels_are_in_the_system(step):
    """
    :type step: lettuce.core.Step
    """
    HOTELS.update({'hotel_name': 'luxury', 'description': 'blablabla', 'email_address': 'blablabla@gmail.com', 'address': 'iligan city',
                    'contact_number': '0987687654', 'google_map': 'kjhg', 'no_of_restaurant': '3', 'no_of_rooms': '50',
                    'extra': 'huhu', 'is_active': 'True'})


@step(u'I retrieve the hotel \'(.*)\' ')
def when_I_retrieve_the_hotel(step, hotel_id):
    """
    :type step: lettuce.core.Step
    """

    world.response = world.app.get('api/hotel/{}/'.format(hotel_id))

@step(u'I should get a \'(.*)\' response')
def then_I_should_get_a_200_response(step, expected_status_code):
    """
    :type step: lettuce.core.Step
    """
    assert_equals(world.response.status_code, int(expected_status_code))

@step(u'the following hotel details are returned:')
def and_the_following_hotel_details_are_returned(step):
    """
    :type step: lettuce.core.Step
    """

    assert_equals(step.hashes, [json.loads(world.response.data)])