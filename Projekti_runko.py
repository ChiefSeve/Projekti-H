import mysql.connector

connect = mysql.connector.connect(
         host='127.0.0.1',
         port=3306,
         database='flight_game',
         user='root',
         password='3042',
         autocommit=True
         )


def startmenu():
    choice = input("Jos haluat aloittaa pelin, kirjoita 1\n"
                   "Jos haluat lopettaa pelin, kirjoita 2: ")
    if choice == "1":
        return True
    elif choice == "2":
        exit("Hyvästi")
    else:
        return False


def startplace():
    cursor = connect.cursor()
    startport = f"SELECT name FROM airport ORDER BY RAND();"
    #Hakee lentokentän listasta
    cursor.execute(startport)
    first = cursor.fetchone()
    print(f"Olet lentokentällä {first}")
    return first


def end():
    print("Hävisit pelin.")
    print(f"Selvisit {jumps} hyppyä.")


def fcheck(frust):
    if frust < 100:
        return True
    else:
        return False


print("Tervetuloa peliin, käyttäjä!")
check = startmenu()
while check is False:
    print("Kirjoita 1 tai 2")
    check = startmenu()
frustration = 0
jumps = 0
while check is True:
    location = startplace()
    while frustration < 100:
        kok = input("Lisää turhautuneisuutta: ")
        frustration += int(kok)
        check = fcheck(frustration)
else:
    end()
