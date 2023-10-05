import helpers.database_helpers as database


def mainmenu(screen_name, weather_goal, nearest_airport):
    user = database.find_player(screen_name)
    weather = database.get_weather_info(weather_goal)
    print(f"""
     +--------------------------+----------------------------+
     | Voit jatkaa lentämistä.  |                            |
     +--------------------------+----------------------------+
     | Tämänhetkinen sijaintisi | {user["location"]}         |
     |--------------------------+----------------------------|
     | Sinun pitää päästä       | {weather["status"]}        |
     | kentälle, jossa sää on   | {weather["temperature"]} C |
     +--------------------------+----------------------------+
     | Lähin ehdot täyttävä     | {nearest_airport[1]}       |
     | lentoasema on            |                            |
     +--------------------------+----------------------------+
     | Johon on matkaa          | {nearest_airport[0]}       |
     +--------------------------+----------------------------+""")

