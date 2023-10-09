import random
import helpers.connector as connector

my_cursor = connector.mydb.cursor(dictionary=True, buffered=True)

status = ['pilvinen', 'aurinkoinen', 'sateinen', 'luminen', 'sumuinen']


def temperature():
    temp = random.randrange(-15, 31, 5)
    return temp


class Weather:
    def __init__(self, status_c, temperature_c):
        self.status = status_c
        self.temperature = temperature_c


def generate_weather():
    i = 0
    while i <= 30:
        select_sql = '''SELECT * FROM weather'''
        my_cursor.execute(select_sql)
        all_weathers = my_cursor.fetchall()
        if all_weathers:
            for wee in all_weathers:
                weather = Weather(random.choice(status), temperature())
                if wee['status'] != weather.status and wee['temperature'] != weather.temperature:
                    if weather.status == 'luminen' and weather.temperature > 0:
                        print("not valid")
                    elif weather.status == 'sateinen' and weather.temperature <= 0:
                        print("not valid")
                    else:
                        sql = '''INSERT INTO weather (status, temperature) VALUES (%s, %s)'''
                        values = (weather.status, weather.temperature)
                        my_cursor.execute(sql, values)
                        connector.mydb.commit()
                        i += 1
                else:
                    print('Not valid')
        else:
            print(' NO DATA ')
            weather = Weather(random.choice(status), temperature())
            sql = '''INSERT INTO weather (status, temperature) VALUES (%s, %s)'''
            values = (weather.status, weather.temperature)
            my_cursor.execute(sql, values)
            connector.mydb.commit()
            i += 1


# generate_weather()

def get_ariports():
    sql = '''SELECT id FROM airport'''
    my_cursor.execute(sql)
    airports = my_cursor.fetchall()
    return airports


def get_weather():
    sql = '''SELECT * FROM weather ORDER BY RAND()'''
    my_cursor.execute(sql)
    weather = my_cursor.fetchone()
    return weather


def update_weather():
    airports = get_ariports()
    for airport in airports:
        sql = '''UPDATE airport SET weather_id =%s WHERE id = %s'''
        weather = get_weather()
        values = (weather['id'], airport['id'])
        my_cursor.execute(sql, values)
        connector.mydb.commit()


update_weather()
