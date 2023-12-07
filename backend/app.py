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
    airport = database.get_random_airport()
    weather = database.get_random_weather()
    database.create_user_by_name(screen_name, airport, weather)
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
    return result


@app.route('/airport/<icao>')
def airport(icao):
    result = database.get_airport_by_icao(icao)
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
def fly(icao):
    return database.get_airport_by_coordinates(airport_lat, airport_lng)

# Flask app

if __name__ == '__main__':
    app.run(use_reloader=True, host='127.0.0.1', port=3000)

# inputs and prints are moved to web page
