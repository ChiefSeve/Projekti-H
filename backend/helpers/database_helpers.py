import helpers.connector as connector
import json

db = connector.Database()

my_cursor = db.get_conn().cursor(dictionary=True, buffered=True) # connector.mydb.conn.cursor(dictionary=True, buffered=True)


# Airport

def get_random_airport():
    sql = f'SELECT name, type, id, ident FROM airport ORDER BY RAND()'
    my_cursor.execute(sql)
    result = my_cursor.fetchone()
    if result:
        return result
    else:
        return 'ERROR'


def get_random_airports():
    sql = f'SELECT ident, name, weather_id, iso_country, iso_region FROM airport ORDER BY RAND()'
    my_cursor.execute(sql)
    result = my_cursor.fetchall()
    if result:
        return result
    else:
        return 'ERROR'


def get_airports_by_weather(weather_id):
    sql = f'''SELECT ident, name FROM airport WHERE weather_id=%s'''
    my_cursor.execute(sql, (weather_id,))
    result = my_cursor.fetchall()
    if result:
        return result
    else:
        return 'ERROR'


def get_airports_by_weather_and_region(weather_id, iso_region):
    sql = f'''SELECT ident, name FROM airport WHERE weather_id=%s AND iso_region=%s'''
    my_cursor.execute(sql, (weather_id, iso_region))
    result = my_cursor.fetchall()
    if result:
        return result
    else:
        return 'ERROR'


def get_airport_by_icao(icao):
    sql = f'''select ident, name, latitude_deg, longitude_deg, weather_id, iso_region
     FROM airport WHERE ident = %s'''
    my_cursor.execute(sql, (icao,))
    result = my_cursor.fetchone()
    if result:
        return result
    else:
        return 'no data'


def update_airport_weather(weather_id):
    airports = get_random_airport()
    weather = get_random_weather_id(weather_id)
    sql = f'''UPDATE airport SET weather_id = %s WHERE id = %s'''
    my_cursor.execute(sql, (weather['id'], airports['id']))
    if my_cursor.rowcount:
        return True
    else:
        return 'ERROR'


def get_all_airport_icaos():
    sql = 'SELECT ident FROM airport'
    my_cursor.execute(sql)
    a = my_cursor.fetchall()
    if a:
        result = []
        for x in a:
            result.append(x["ident"])
        return result
    else:
        return 'ERROR'


def get_all_airports():
    sql = f'''SELECT name, ident, latitude_deg, longitude_deg
              FROM airport'''
    my_cursor.execute(sql)
    result = my_cursor.fetchall()
    return json.dumps(result)


def get_airport_by_coordinates(lat, lng):
    sql = '''SELECT ident FROM airport 
    WHERE latitude_deg= %s
    AND longitude_deg= %s'''
    val = (lat, lng)
    my_cursor.execute(sql, val)
    data = my_cursor.fetchone()
    return data


# Region


def get_random_region():
    sql = 'SELECT iso_region FROM airport ORDER BY RAND()'
    my_cursor.execute(sql)
    result = my_cursor.fetchone()
    if result:
        return result["iso_region"]
    else:
        return 'ERROR'


def update_region_airport_weather(weather_id, region):
    sql = '''SELECT id FROM airport WHERE iso_region =%s'''
    my_cursor.execute(sql, (region,))
    data = my_cursor.fetchone()
    new_sql = '''UPDATE airport SET weather_id = %s WHERE id = %s'''
    val = (weather_id, data['id'])
    my_cursor.execute(new_sql, val)
    if my_cursor.rowcount:
        return True
    else:
        return 'ERROR'
    

# Weather


def get_random_weather_id():
    sql = f'''SELECT id FROM weather order by RAND()'''
    my_cursor.execute(sql)
    result = my_cursor.fetchone()
    if result:
        return result
    else:
        return 'ERROR'


def get_random_weather():
    sql = f'''SELECT * FROM weather order by RAND()'''
    my_cursor.execute(sql)
    result = my_cursor.fetchone()
    if result:
        return result
    else:
        return 'ERROR'


def get_weather_info(weather_id):
    sql = f'''select * from weather where id = %s'''
    my_cursor.execute(sql, (weather_id,))
    return my_cursor.fetchone()


def get_assigned_weather_id():
    sql = 'SELECT DISTINCT weather_id FROM airport ORDER BY RAND()'
    my_cursor.execute(sql)
    result = my_cursor.fetchone()
    if result:
        return result["weather_id"]
    else:
        return 'ERROR'


# Player

def update_player_goal(weather_id, user_id):
    sql = f'''UPDATE game SET weather_id = %s WHERE id = %s'''
    values = (weather_id, user_id)
    my_cursor.execute(sql, values)
    if my_cursor.rowcount:
        return True
    else:
        return 'ERROR'


def find_player(name):
    sql = f'''SELECT * FROM game where screen_name = %s'''
    my_cursor.execute(sql, (name,))
    data_res = my_cursor.fetchone()
    if data_res:
        return data_res
    else:
        return 'no data'
    

def get_player_by_id(id):
    sql = f'''SELECT * FROM game where id=%s'''
    my_cursor.execute(sql, (id, ))
    data_res = my_cursor.fetchone()
    if data_res:
        return data_res
    else:
        return 'no data'


def get_all_players():
    sql = f'''SELECT * from game'''
    my_cursor.execute(sql)
    data_res = my_cursor.fetchall()
    if data_res:
        return data_res
    else:
        return 'no data'


def get_all_screen_names():
    sql = f'''SELECT screen_name FROM game'''
    my_cursor.execute(sql)
    data_res = my_cursor.fetchone()
    if data_res:
        return data_res
    else:
        return 'no data'


def create_user_by_name(name, start_airport, start_weather):
    sql = f"INSERT INTO game (screen_name, frustration, location, weather_id, score, range, jumps) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (name, 0, start_airport['ident'], start_weather['id'], 0, 2778, 0)
    my_cursor.execute(sql, values)
    if my_cursor.rowcount:
        return True
    else:
        return 'ERROR'


def reset_frustration(player_id):
    sql = f'''UPDATE game SET frustration=0 WHERE id=%s'''
    my_cursor.execute(sql, (player_id,))
    if my_cursor.rowcount:
        return True
    else:
        return 'ERROR'


def update_player_location(icao, player):
    sql = f'''UPDATE game SET location=%s WHERE id=%s'''
    val = (icao, player)
    my_cursor.execute(sql, val)
    if my_cursor.rowcount:
        return True
    else:
        return 'ERROR'


def update_player_frustration(frust, player_id):
    sql = f'''UPDATE game SET frustration=%s WHERE id=%s'''
    val = (frust, player_id)
    my_cursor.execute(sql, val)
    if my_cursor.rowcount:
        return True
    else:
        return 'ERROR'


def update_player_range(new_range, player_id):
    sql = f'''UPDATE game SET range=%s WHERE id=%s'''
    val = (new_range, player_id)
    my_cursor.execute(sql, val)
    if my_cursor.rowcount:
        return True
    else:
        return 'ERROR'


def update_player_score(new_score, player_id):
    sql = f'''UPDATE game SET score=%s WHERE id=%s'''
    val = (new_score, player_id)
    my_cursor.execute(sql, val)
    if my_cursor.rowcount:
        return True
    else:
        return 'ERROR'