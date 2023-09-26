import helpers.connector as connector
def this_thing(inp):
    my_cursor = connector.mydb.cursor()
    sql = f'SELECT name, type FROM airport WHERE iso_country="{inp.upper()}"'
    my_cursor.execute(sql)
    data_result = my_cursor.fetchall()
    if data_result:
        return data_result
    else:
        return 'ERROR'

