import helpers.database_helpers as database
from geopy import distance
import random
import modules.app_functions as module


def main_app():
    jumps = 0
    flight_range = 2778
    exit_button = '0'
    player_name = input("Tervetuloa peliin! Syötä nimi: ")
    # airport_icaos = database.get_all_airport_icaos()
    user = module.find_player(player_name)
    if user == 'no data':
        print(f'Käyttäjää ei löytynyt, luoodaan se')
        module.create_user(player_name)
        user = module.find_player(player_name)
    else:
        print(f'Tervetuloa takaisin, {player_name}')
    frustration = 0
    module.create_new_weather_goal(user['id'])
    weather = database.get_weather_info(user['weather_id'])
    nearest_eligible_airport = module.find_nearest_eligible_airport(user["weather_id"], user["location"])
    print(f'Sinun pitää päästä lentokentälle missä {weather["status"]} ja {weather["temperature"]} astetta. '
          f'Voit lentää {flight_range} km kerrallaan.')
    print(f'Tämänhetkinen sijaintisi on {user["location"]}.')
    print(f'Lähin ehdot täyttävä lentoasema on {nearest_eligible_airport[1]}, '
          f'johon on matkaa {nearest_eligible_airport[0]} km.')
    while True:
        # tässä kohdassa luodaan pelaajalle tavoite säätila. katsotaan aina kun lennetään uudelle lentokentälle eli päivitetään game taulussa location.
        # Jos pelaaja lentää kentälle missä on oikea säätila, ei nosteta "frustration" määrää ja luodaan uusi ´säätila tavoite. Muuten jatketaan samalla tavoitteella.
        while int(frustration) < 100:
            user = module.find_player(player_name)
            print("")
            print('1. Lennä toiselle lentoasemalle.')
            print('2. Hae tiedot lentoasemasta.')
            print('3. Laske kahden lentoaseman välinen etäisyys.')
            print('4. Lopeta peli.')
            print("")
            print(f'Voit jatkaa lentämistä. Valitse vaihtoehdoista jatkaaksesi ({user["location"]})\n')
            choice = input()
            # airports_in_range = module.all_airports_in_range(user["location"])

            while choice == '1' or choice == '1.':
                destination = input('Syötä kohdelentokenttäsi ICAO-koodi: ')
                while database.get_airport_by_icao(destination) == 'no data':
                    if destination == exit_button:
                        break
                    print('ICAO-koodia ei ole olemassa.')
                    destination = input('Syötä kohdelentokenttäsi ICAO-koodi: ')
                if destination == exit_button:
                    break
                in_range = module.check_if_inside_range2(user["location"], destination)
                while not in_range:
                    print(f'Kohdelentokenttäsi on liian kaukana (> {flight_range})')
                    destination = input('Syötä kohdelentokenttäsi ICAO-koodi: ')
                    if destination == exit_button:
                        break
                    in_range = module.check_if_inside_range2(user["location"], destination)
                if destination == exit_button:
                    break

                if destination == user["location"]:
                    print(f'Olet jo kohteessa {user["location"]}.')
                    input('Paina Enter jatkaaksesi.')
                    break

                module.change_current_airport(destination.upper(), user['id'])
                current_location = database.get_airport_by_icao(destination.upper())
                new_frust = module.frustration_adder(current_location['weather_id'], user['weather_id'])
                frustration += new_frust
                print(frustration)
                break

            while choice == '2' or choice == '2.':
                search_icao = input('Anna lentoaseman ICAO-koodi: ')
                while not module.is_airport(search_icao):
                    if search_icao == exit_button:
                        break
                    print('ICAO-koodia ei ole olemassa.')
                    search_icao = input('Anna lentoaseman ICAO-koodi: ')
                if search_icao == exit_button:
                    break
                search_distance = module.calculate_distance(user["location"], search_icao)
                search_airport = database.get_airport_by_icao(search_icao)
                search_weather = database.get_weather_info(search_airport["weather_id"])
                print(f'\nNimi: {search_airport["name"]}')
                print(f'Maa: {search_airport["iso_country"]}')
                print(f'Alue: {search_airport["iso_region"]}')
                # print(f'Säätila: {search_weather["status"]}, {search_weather["temperature"]} C')
                # weatheriin liittyvät tässä kaataa ohjelman toistaiseksi, koska kaikilla kentillä weather_id = NULL
                # toimii kun lisää kentälle weather_id:n
                print(f'Etäisyys: {search_distance}')
                input('\nPaina Enter jatkaaksesi.')
                break

            while choice == '3' or choice == '3.':
                distance_airport1 = input('Anna 1. lentoaseman ICAO-koodi: ')
                while not module.is_airport(distance_airport1):
                    if distance_airport1 == exit_button:
                        break
                    print('ICAO-koodia ei ole olemassa.')
                    distance_airport1 = input('Anna 1. lentoaseman ICAO-koodi: ')
                if distance_airport1 != exit_button:
                    distance_airport2 = input('Anna 2. lentoaseman ICAO-koodi: ')
                    while not module.is_airport(distance_airport2):
                        if distance_airport2 == exit_button:
                            break
                        print('ICAO-koodia ei ole olemassa.')
                        distance_airport2 = input('Anna 2. lentoaseman ICAO-koodi: ')
                if distance_airport1 == exit_button or distance_airport2 == exit_button:
                    break
                distance_result = module.calculate_distance(distance_airport1, distance_airport2)
                print(f'{distance_airport1}:n ja {distance_airport2}:n välinen etäisyys on {distance_result}')
                input('\nPaina Enter jatkaaksesi')
                break

            while choice == '4' or choice == '4.':
                exit()

        else:
            print(f'Peli loppui. Lensit {jumps} kertaa')
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