import json
import modules.app_functions as module
import helpers.database_helpers as database
from flask import Flask, request
from helpers.connector import Database
from flask_cors import CORS

db = Database()
app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'


# Get screen names
@app.route('/screen_names')
def get_screen_names():
    data = database.get_all_screen_names()
    return json.dumps(data)


# Create user
@app.route('/create_user')
def create_user():
    args = request.args
    screen_name = args.get('screen_name')
    module.create_user(screen_name)

    player = database.find_player(screen_name)
    return json.dumps(player)


# Get User(s)

@app.route('/getUser')
def user():
    args = request.args
    id = args.get('id')
    result = database.get_player_by_id(id)
    return json.dumps(result)


@app.route('/getUser/all')
def users():
    result = database.get_all_players()
    return json.dumps(result)

# Airports

@app.route('/airportsAll/')
def countries_by_continent():
    result = database.get_all_airports()
    return json.dumps(result)


@app.route('/airport/<icao>')
def airport(icao):
    result = database.get_airport_by_icao(icao)
    return json.dumps(result)


@app.route('/airport/<weather_id>')
def airport_by_weather(weather_id):
    print('---------------------------------------------------------')
    result = database.get_airports_by_weather(weather_id)
    return json.dumps(result)


# Weather


@app.route('/weather')
def get_weather():
    args = request.args
    weather_id = args.get('weather')
    result = database.get_weather_info(weather_id)
    return json.dumps(result)


# Game Functions

@app.route('/calculateDistance')
def distance():
    args = request.args
    airportFrom = args.get('from')
    airportTo = args.get('to')
    result = module.calculate_distance(airportFrom, airportTo)
    return json.dumps(result)


@app.route('/fly/')
# User ID, Lentokenttä ICAO, Katsotaan että on etäisyyden sisällä
def fly():
    args = request.args
    icao = args.get('icao')
    user_id = args.get('userId')
    player = database.get_player_by_id(user_id)
    airport = database.get_airport_by_icao(icao)
    airport_distance = module.calculate_distance(player["location"], icao)
    if airport_distance <= player["flight_range"]:
        database.update_player_location(icao, user_id)
        player = database.get_player_by_id(user_id)
        frust = module.frustration_adder(
            player["weather_id"],
            airport["weather_id"],
            airport["iso_region"],
            player["region_goal"]
        )
        new_frust = player["frustration"] + frust
        if new_frust >= 100:
            database.clear_player_data(player['id'])
            return json.dumps({"game_over": True})
        else:
            database.update_player_frustration(new_frust, player["id"])
            if airport["weather_id"] == player["weather_id"]:
                new_score = player["score"] + 1
                database.update_player_score(new_score, player["id"])
                module.create_new_weather_goal(player['id'])
            if player["score"] == 3:
                new_range = player["flight_range"] / 2
                database.update_player_range(new_range, player["id"])
            elif player["score"] == 5:
                new_range = player["flight_range"] / 2
                database.update_player_range(new_range, player["id"])
    else:
        return json.dumps({"too_far": True})
    
    player = database.get_player_by_id(user_id)

    return json.dumps(player)


# Flask app

if __name__ == '__main__':
    app.run(use_reloader=True, host='127.0.0.1', port=3000)

# inputs and prints are moved to web page
