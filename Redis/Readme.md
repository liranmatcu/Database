# Source: https://geshan.com.np/blog/2022/01/redis-docker/

# Start
docker-compose up cache
docker-compose up -d cache
docker-compose run cache

# Drop in
docker-compose exec cache /bin/sh
/data # redis-cli
127.0.0.1:6379> auth password

keys *
MGET Ma

## or
docker exec -it redis_cache_1 redis-cli -a password



# List volume
docker volume ls



# Direct start from docker command 
docker run --rm --name test-redis redis:6.2-alpine redis-server --loglevel warning


https://citizix.com/how-to-run-redis-6-with-docker-and-docker-compose/
docker-compose exec cache /bin/sh
