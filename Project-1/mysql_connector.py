# pip install mysql-connector-python
import mysql.connector


host_name = "127.0.0.1"
db_user = "root"
db_password = "password"
db_name = "bookmanager"

connection = mysql.connector.connect(host=host_name, user=db_user, 
                                    password=db_password, database=db_name) 


# A testing case: show 5 publishers
# cursor = connection.cursor()
# query = "select name, city from bookmanager.Publisher limit 5"
# cursor.execute(query)
# results = cursor.fetchall()
# print('Publisher Name\t', 'Location')
# for row in results:
#     print(row[0], '\t', row[1])

# connection.close()



