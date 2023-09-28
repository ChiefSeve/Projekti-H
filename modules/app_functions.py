from geopy import distance
import helpers.database_helpers as connector


def calculate_distance(current, target):
    start = connector.get_airport_by_icao(current)
    end = connector.get_airport_by_icao(target)
    return distance.distance((start['latitude_deg'], start['longitude_deg']),
                             (end['latitude_deg'], end['longitude_deg'])).km


def check_if_inside_range(icao):
    # jos lentokenttä palaa etäisyydellä <1500nm(2778km) se hyväksytään, muuten ei
    airport_list = connector.get_random_airports()
    for airport in airport_list:
        dis = (calculate_distance(icao, airport['ident']))
        if dis < 2778:
            return airport


check_if_inside_range('foobar')


# def generate_weather():
#     connector.update_airport_weather()
# def end():
#     print("Hävisit pelin.")
#     print(f"Selvisit {jumps} hyppyä.")
#
#
# def frustration_check(frustration):
#     if frustration < 100:
#         return True
#     else:
#         return False


def find_player(name):
    player = connector.find_player(name)
    if player != 'no data':
        return player
    else:
        return 'no data'


def create_user(name):
    airport = connector.get_start_airport()
    location = airport[1]
    resp = connector.create_user_by_name(name)
    if resp != 'ERROR':
        return resp
