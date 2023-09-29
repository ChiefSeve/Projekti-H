import helpers.connector as connector

my_cursor = connector.mydb.cursor(dictionary=True)


def get_random_airport():
    sql = f'SELECT name, type, id FROM airport ORDER BY RAND()'
    my_cursor.execute(sql)
    data_result = my_cursor.fetchone()
    if data_result:
        return data_result
    else:
        return 'ERROR'


def get_current_location(icao):
    sql = f'SELECT ident, name, latitude_deg, longitude_deg FROM airport WHERE ident ="{icao}"'
    my_cursor.execute(sql)
    return my_cursor.fetchone()


def get_random_airports():
    sql = f'SELECT ident, name FROM airport ORDER BY RAND() limit 30'
    my_cursor.execute(sql)
    result = my_cursor.fetchall()
    return result

def get_airport_by_icao(icao):
    sql = f'''select iso_country, ident, name, latitude_deg, longitude_deg FROM airport WHERE ident = %s'''
    my_cursor.execute(sql, (icao,))
    return my_cursor.fetchone()


def get_random_weather_id():
    sql = f'''SELECT id FROM weather'''
    my_cursor.execute(sql)
    return my_cursor.fetchone()

def update_player_goal(weather_id, user_id):
    sql = f'''UPDATE game SET weather_id = %s WHERE id = %s'''
    my_cursor.execute(sql, (weather_id, user_id,))
    connector.mydb.commit()

def update_airport_weather(weather_id):
    airports = get_random_airport()
    weather = get_random_weather_id()
    sql = f'''UPDATE airport SET weather_id = %s WHERE id = %s'''
    return my_cursor.execute(sql, (weather['id'], airports['id']))


def get_start_airport():
    sql = f"SELECT name, ident FROM airport ORDER BY RAND() LIMIT 1;"
    # Hakee lentokentän listasta
    my_cursor.execute(sql)
    first = my_cursor.fetchone()
    return first


def find_player(name):
    sql = f'''SELECT * FROM game where screen_name = %s'''
    my_cursor.execute(sql, (name,))
    data_res = my_cursor.fetchone()
    if data_res:
        return data_res
    else:
        return 'no data'


def create_user_by_name(name):
    sql = f'INSERT INTO game (screen_name) VALUES ("{name}")'
    my_cursor.execute(sql)
    connector.mydb.commit()
    print(my_cursor.rowcount, 'ROWCOUNTSS')


def update_player_location(icao, player):
    sql = f"UPDATE game SET location={icao} WHERE screen_name={player}"
    my_cursor.execute(sql)
