import helpers.database_helpers as database
from geopy import distance
import random

result = database.get_random_airports('foo')
if result != 'ERROR':
    for y in result:
        print(y, 'foobar')
else:
    print('ERROR :(')
