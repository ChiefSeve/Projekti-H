import helpers.database_helpers as database
from geopy import distance
import random
import modules.app_functions as module


def main_app():
    player_name = input("Tervetuloa peliin! Syötä nimi: ")
    user = module.find_player(player_name)
    if user == 'no data':
        print(f'Käyttäjää ei löytynyt, luoodaan se')
        module.create_user(player_name)
        user = module.find_player(player_name)
    else:
        print(f'Tervetuloa takaisin, {user["name"]}')
    frustration = user['frustration']
    while True:
        # tässä kohdassa luodaan pelaajalle tavoite säätila. katsotaan aina kun lennetään uudelle lentokentälle eli päivitetään game taulussa location.
        # Jos pelaaja lentää kentälle missä on oikea säätila, ei nosteta "frustration" määrää ja luodaan uusi ´säätila tavoite. Muuten jatketaan samalla tavoitteella.
        if int(frustration) < 100:
            print('Voit jatkaa lentämistä')
            module.check_if_inside_range(user['location'])
        else:
            return False
# while check is False:
#     print("Kirjoita 1 tai 2")
#     check = start_menu()
# frustration = 0
# jumps = 0
# while check is True:
#     location = startplace()
#     while frustration < 100:
#         kok = input("Lisää turhautuneisuutta: ")
#         frustration += int(kok)
#         check = fcheck(frustration)
# else:
#     end()

main_app()