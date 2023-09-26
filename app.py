import helpers.database_helpers as database
from geopy import distance
import random

result = database.this_thing(input('anna iso_country: '))
if result != 'ERROR':
    for y in result:
        if y[1] != 'closed':
            if y[1] == 'heliport':
                print(y[0], 'IS A HELIPORT')
else:
    print('ERROR :(')