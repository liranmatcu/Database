from pymongo_connector import collection

def findAll():
    results = collection.find()
    return results


def findByTitle(book_title):
    results = collection.find({'title': book_title})
    return results
