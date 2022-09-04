# Start MongoDB server and Mongo-express
docker-compose up -d

# Start MongoDB server container
docker-compose up -d mongo

## Drop into the  MongoDB container
docker exec -it mongo mongosh admin -u root -p password
Default password for root is: password
<!-- mongo admin -u root -p rootpassword -->


# Access Mongo-express via a browser
http://127.0.0.1:8081
or
http://localhost:8081

# Default username is
mexpress	
# Default password is 
mexpress



# Reference
https://devops.tutorials24x7.com/blog/containerize-mongodb-and-mongo-express-using-docker-containers
https://dev.to/sonyarianto/how-to-spin-mongodb-server-with-docker-and-docker-compose-2lef
