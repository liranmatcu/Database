from mysql_connector import connection

def findAll():

    cursor = connection.cursor()
    query = "select * from bookmanager.Book"
    cursor.execute(query)
    results = cursor.fetchall()
    connection.close()

    return results
    
    