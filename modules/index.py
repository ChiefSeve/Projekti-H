from geopy import distance
import helpers.database_helpers as connector


def calculate_distance(current, target):
    start = connector.get_airport_by_icao(current)
    end = connector.get_airport_by_icao(target)
    return distance.distance((start['latitude_deg'], start['longitude_deg']),
                             (end['latitude_deg'], end['longitude_deg'])).km



def generate_weather():
    connector.update_airport_weather()