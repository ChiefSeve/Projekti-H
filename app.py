import helpers.database_helpers as database
from geopy import distance
import random
import modules.app_functions as module


def main_app():
    jumps = 0
    player_name = input("Tervetuloa peliin! Syötä nimi: ")
    user = module.find_player(player_name)
    if user == 'no data':
        print(f'Käyttäjää ei löytynyt, luoodaan se')
        module.create_user(player_name)
        user = module.find_player(player_name)
    else:
        print(player_name)
        print(f'Tervetuloa takaisin,{player_name}')
    frustration = user['frustration']
    module.create_new_weather_goal(user['id'])
    weather = database.get_weather_info(user['weather_id'])
    print(user, 'useriii')
    print(f'Sinun pitää päästä lentokentälle missä {weather["status"]} ja {weather["temperature"]} astetta')
    while True:
        # tässä kohdassa luodaan pelaajalle tavoite säätila. katsotaan aina kun lennetään uudelle lentokentälle eli päivitetään game taulussa location.
        # Jos pelaaja lentää kentälle missä on oikea säätila, ei nosteta "frustration" määrää ja luodaan uusi ´säätila tavoite. Muuten jatketaan samalla tavoitteella.
        if int(frustration) < 100:
            print('Voit jatkaa lentämistä')
            airports = module.check_if_inside_range(user['location'])
            for airport in airports:
                print(airport['ident'], 'airport')
            destination = input('minne mennään: ')
            module.change_current_airport(destination, user['id'])
        else:
            print(f'Peli loppui. lensit {jumps} kertaa')
            return False
# while check is False:
#     print("Kirjoita 1 tai 2")
#     check = start_menu()
#     while check is True:
#     location = startplace()
#         kok = input("Lisää turhautuneisuutta: ")
#         frustration += int(kok)
#         check = fcheck(frustration)
# else:
#     end()

main_app()