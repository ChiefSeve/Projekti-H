from geopy import distance
import helpers.database_helpers as connector
from dotenv import load_dotenv
import os


def calculate_distance(current, target):
    start = connector.get_airport_by_icao(current)
    end = connector.get_airport_by_icao(target)
    return distance.distance((start['latitude_deg'], start['longitude_deg']),
                             (end['latitude_deg'], end['longitude_deg'])).km


def check_if_inside_range(icao, flight_range):
    # jos lentokenttä palaa etäisyydellä <1500nm(2778km) se hyväksytään, muuten ei
    airport_list = connector.get_random_airports()
    airports_in_range = []
    for airport in airport_list:
        dis = (calculate_distance(icao, airport['ident']))
        if dis < flight_range:
            airports_in_range.append(airport)
    return airports_in_range


def check_if_inside_range2(user_icao, destination_icao, flight_range):
    airport = connector.get_airport_by_icao(destination_icao)
    distance3 = calculate_distance(user_icao, airport["ident"])
    if distance3 <= flight_range:
        return True
    else:
        return False


def is_airport(icao):
    result = connector.get_airport_by_icao(icao)
    if result == 'no data':
        return False
    else:
        return True


def all_airports_in_range(icao, flight_range):
    # jos lentokenttä palaa etäisyydellä <1500nm(2778km) se hyväksytään, muuten ei
    airport_list = connector.get_all_airport_icaos()
    airports_in_range = []
    for airport in airport_list:
        dis = calculate_distance(icao, airport)
        if dis < flight_range:
            airports_in_range.append(airport)
    return airports_in_range


def create_new_weather_goal(player_id):
    weather = connector.get_random_weather_id()
    # this is not our top priority, we will do it if we have time
    # connector.update_airport_weather(weather['id'])
    connector.update_player_goal(weather['id'], player_id)


def find_player(name):
    player = connector.find_player(name)
    if player != 'no data':
        return player
    else:
        return 'no data'


def create_user(name):
    airport = connector.get_random_airport()
    start_weather = connector.get_random_weather_id()
    resp = connector.create_user_by_name(name, airport, start_weather)
    if resp != 'ERROR':
        return resp


def frustration_adder(goal_id, local_weather_id):
    frust = 0
    goal = connector.get_weather_info(goal_id)
    weather = connector.get_weather_info(local_weather_id)
    if goal == weather:
        frust += 0
        return frust
    elif goal['status'] == weather['status']:
        frust += 5
        return frust
    elif goal['temperature'] == weather['temperature']:
        frust += 5
        return frust
    else:
        frust += 10
        return frust


def change_current_airport(icao, player):
    connector.update_player_location(icao, player)
    return True


def find_nearest_eligible_airport(weather_id, player_location):
    airports = connector.get_airports_by_weather(weather_id)
    airport_list = []
    for airport in airports:
        distance1 = calculate_distance(player_location, airport["ident"])
        airport_list.append((distance1, airport["ident"]))
    airport_list.sort()
    result = airport_list[0]
    return result
