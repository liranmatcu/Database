# Start a Docker MongoDB instance (in the MongoDB folder)
docker-compose up -d mongo

# Drop into the MongoDB instance
docker exec -it mongo mongosh admin -u root -p password

# Show databases
show dbs
# Switch to a database
use bookmanager
db
# Show collections
show collections

# Retrieve records/documents from the Book collection
db.Book.find()
db.Book.find({"title": "Java Programming"})
db.Book.find({"title": "Java Programming"}).count()


-- Wild cards
db.Book.find({"title": /.*Java.*/})
db.Book.find({"title": /Java/})
db.Book.find({"title": /DB/}).limit(3)
db.Book.find({"title": /DB/}).limit(3).sort({"year": -1})
db.Book.find({"title": /DB/}).sort({"year": 1, "price": -1})

-- Multiple fields OR and AND logic
db.Book.find({$and: [{"title": /DB/}, {"published_by": "ABC"}]})
db.Book.find({$and: [{"title": /DB/}, {"published_by": {$ne: "ABC"}}]})

db.Book.find({"year": 2013})
db.Book.find({$or: [{"year": 2013}, {"year": 2015}]})

db.Book.find({"year": {$gte : 2015}})
db.Book.find({"year": {$lte : 2013}})
db.Book.find({$and: [{"year": {$lte : 2015}}, {"year": {$gte : 2013}}]})


# Retrieve (find) records/documents with projection
db.Book.find({"title": /DB/}, {"published_by": 1})
db.Book.find({"title": /DB/}, {"published_by": 1, "title": 1})
db.Book.find({"title": /DB/}, {"published_by": 1, "title": 1, "_id": 0})



# Insert a document/record to the collection of book
Synopsis: db.<collection>.insertOne(Doc-in-JSON)
db.Book.insertOne({"title": "MongoDB", "ISBN": "2123456789", "published_by": "TCU", "year": 2022, "price": 23, "TCU student discount": 0.5})
db.Book.find({"title":"MongoDB"})
db.Book.find({"title":/Mon/})


insertMany()
db.Book.insertMany([
{Book 1 data},
{Book 2 data},
{Book 3 data}
])


# Update a document
db.Book.updateOne(
   { "title":"MongoDB" },
   {
     $set: { "price": 60, "Author": "Super Frog" },
     $currentDate: { lastModified: true }
   }
)

# Delete a document
db.Book.deleteOne(
   { "title":"MongoDB" }
)



# ObjectId is similar to "Primary Key"
ObjectId()
