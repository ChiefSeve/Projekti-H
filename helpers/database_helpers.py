import helpers.connector as connector

my_cursor = connector.mydb.cursor(dictionary=True, buffered=True)


def get_random_airport():
    sql = f'SELECT name, type, id FROM airport ORDER BY RAND()'
    my_cursor.execute(sql)
    data_result = my_cursor.fetchone()
    if data_result:
        return data_result
    else:
        return 'ERROR'


def get_random_airports():
    sql = f'SELECT ident, name, weather_id FROM airport ORDER BY RAND() limit 30'
    my_cursor.execute(sql)
    result = my_cursor.fetchall()
    return result


def get_airport_by_icao(icao):
    sql = f'''select iso_country, ident, name, latitude_deg, longitude_deg, weather_id FROM airport WHERE ident = %s'''
    my_cursor.execute(sql, (icao,))
    return my_cursor.fetchone()


def get_start_airport():
    sql = f"SELECT name, ident FROM airport ORDER BY RAND() LIMIT 1;"
    # Hakee lentokentän listasta
    my_cursor.execute(sql)
    first = my_cursor.fetchone()
    return first


def get_random_weather_id():
    sql = f'''SELECT id FROM weather order by RAND()'''
    my_cursor.execute(sql)
    return my_cursor.fetchone()


def update_player_goal(weather_id, user_id):
    sql = f'''UPDATE game SET weather_id = %s WHERE id = %s'''
    values = (weather_id, user_id)
    data = my_cursor.execute(sql, values)
    connector.mydb.commit()


def update_airport_weather(weather_id):
    airports = get_random_airport()
    weather = get_random_weather_id(weather_id)
    sql = f'''UPDATE airport SET weather_id = %s WHERE id = %s'''
    my_cursor.execute(sql, (weather['id'], airports['id']))
    connector.mydb.commit()


def find_player(name):
    sql = f'''SELECT * FROM game where screen_name = %s'''
    my_cursor.execute(sql, (name,))
    data_res = my_cursor.fetchone()
    if data_res:
        return data_res
    else:
        return 'no data'


def get_weather_info(weather_id):
    sql = f'''select * from weather where id = %s'''
    my_cursor.execute(sql, (weather_id,))
    return my_cursor.fetchone()

 # TODO change start airport to random, now it is hard coded
def create_user_by_name(name):
    sql = f'''INSERT INTO game (screen_name, frustration, location, weather_id) VALUES (%s, %s, %s, %s)'''
    values = (name, 0, 'KABE', 1)
    my_cursor.execute(sql, values)
    connector.mydb.commit()


def reset_frustration(player_id):
    sql = f'''UPDATE game SET frustration = 0 WHERE id %s'''
    my_cursor.execute(sql, (player_id,))
    connector.mydb.commit()


def update_player_location(icao, player):
    sql = f'''UPDATE game SET location=%s WHERE id=%s'''
    val = (icao, player)
    my_cursor.execute(sql, val)
    connector.mydb.commit()
