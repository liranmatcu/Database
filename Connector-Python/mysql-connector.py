# pip install mysql-connector-python
import mysql.connector


host_name = "127.0.0.1"
db_user = "root"
db_password = "password"
db_name = "trading"

connection = mysql.connector.connect(host=host_name, user=db_user, 
                                    password=db_password, database=db_name) 
cursor = connection.cursor()


query = "select * from trading.members limit 5"
# query = "select first_name, region from trading.members limit 10"

cursor.execute(query)
results = cursor.fetchall()

print(results)
# print(type(results))

# print("First Name", "  ", "Region")
# for row in results:
#     print(row[0], "      ", row[1])
    # print(f"")

connection.close()



