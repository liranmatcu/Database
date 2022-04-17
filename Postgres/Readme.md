
# Start PostgreSQL Database Server container in a terminal
docker-compose up db
docker-compose up db -d


# Log into the PostgreSQL container
docker exec -it pg-container bash
psql -h localhost -U postgres

# Create a new user and its database
su - postgres
createuser ma
createdb ma
psql
alter user ma with encrypted password 'pass';
grant all privileges on database ma to ma ;


# pgAdminer
docker-compose up adminer
docker-compose up adminer -d

http://127.0.0.1:8080
# Default username for PostgreSQL 
postgres
# Default password is 
example


https://towardsdatascience.com/local-development-set-up-of-postgresql-with-docker-c022632f13ea

https://hub.docker.com/_/postgres