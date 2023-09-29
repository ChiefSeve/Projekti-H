# update
# game taulussa on location, joka on isocode. Tämä pitää päivittää valitun lentokentän isocodeen


sql = 'UPDATE game SET locaton = %s'
execute(sql, new_location)