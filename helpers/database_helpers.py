import helpers.connector as connector
my_cursor = connector.mydb.cursor()


def get_random_airport():
    sql = f'SELECT name, type, id FROM airport ORDER BY RAND()'
    my_cursor.execute(sql)
    data_result = my_cursor.fetchone()
    if data_result:
        return data_result
    else:
        return 'ERROR'


def get_airport_by_icao(icao):
    sql = f'''select iso_country, ident, name, latitude_deg, longitude_deg FROM airport WHERE ident = %s'''
    my_cursor.execute(sql, (icao,))
    return my_cursor.fetchone()


def get_random_weather_id():
    sql = f'''SELECT id FROM weather'''
    my_cursor.execute(sql)
    return my_cursor.fetchone()


def update_airport_weather():
    airports = get_random_airport()
    weather = get_random_weather_id()
    sql = f'''UPDATE airport SET weather_id = %s WHERE id = %s'''
    return my_cursor.execute(sql, (weather['id'], airports['id']))
