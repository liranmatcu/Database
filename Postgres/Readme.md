
# Start PostgreSQL Database Server container in a terminal
docker-compose up db -d
docker-compose up db 


# Log into the PostgreSQL container
docker exec -it pg-container bash
psql -h localhost -U postgres

docker run -it --rm postgres psql -h 127.0.0.1 -U postgres
docker run -it --rm postgres psql -h pg-container -U postgres

# Create a new user and its database
su - postgres
createuser ma
createdb ma
psql
alter user ma with encrypted password 'pass';
grant all privileges on database ma to ma ;


# pgAdmin
docker-compose up pgadmin -d

# Adminer
docker-compose up adminer -d
docker-compose up adminer 

http://127.0.0.1:8080
# Default username for PostgreSQL 
postgres
# Default password is 
example


https://towardsdatascience.com/how-to-run-postgresql-and-pgadmin-using-docker-3a6a8ae918b5
https://github.com/lifeparticle/PostgreSql-Snippets

https://towardsdatascience.com/local-development-set-up-of-postgresql-with-docker-c022632f13ea

https://hub.docker.com/_/postgres