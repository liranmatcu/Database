# Start php-nginx instance
docker run --name php --net=mysql_default --rm -p 80:8080 -v "$PWD"/scripts:/var/www/html trafex/php-nginx

## Check docker networks to make sure that you can join the mysql instance's network
docker network ls

# Drop in
docker exec -it php sh


# Web access
http://localhost
http://localhost/test-connection.php
http://localhost/query.php


# Source https://hub.docker.com/r/trafex/php-nginx

