# pip install pymongo
# pip install dnspython


import pymongo

dbname = "bookmanager"
collection = "Book"

myclient = pymongo.MongoClient("mongodb://root:password@127.0.0.1:27017/")
# print(myclient.list_database_names())

mydb = myclient[dbname]

# Get a collection
collection = mydb[collection]

# item_details = collection.find()
# for item in item_details:
#     # This does not give a very readable output
#     print(item['title'], item['year'])






# host_name="127.0.0.1"
# db_user="root"
# db_password="password"
# db_name="company"

# def get_database():
#     from pymongo import MongoClient
#     import pymongo

#     # Provide the mongodb atlas url to connect python to mongodb using pymongo
#     CONNECTION_STRING = "mongodb+srv://db_user:db_password@host_name"

#     # Create a connection using MongoClient. You can import MongoClient or use pymongo.MongoClient
#     from pymongo import MongoClient
#     client = MongoClient(CONNECTION_STRING)

#     # Create the database for our example (we will use the same database throughout the tutorial
#     return client['company']
    
# # This is added so that many files can reuse the function get_database()
# if __name__ == "__main__":    
    
#     # Get the database
#     dbname = get_database()

