# Source https://hub.docker.com/r/trafex/php-nginx


# Start
docker run --name php --net=mysql_default --rm -p 80:8080 -v "$PWD"/scripts:/var/www/html trafex/php-nginx

## check docker networks: 
docker network ls

# Drop in
docker exec -it php sh


# Web access
http://localhost/test-connection.php
http://localhost/query.php


