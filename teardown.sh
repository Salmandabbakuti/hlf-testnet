 
echo 'Clearing Network..'

echo 'Clearing  docker containers..'

#STOP AND DELETE THE DOCKER CONTAINERS
docker ps -aq | xargs -n 1 docker stop
docker ps -aq | xargs -n 1 docker rm -v

# DELETE THE OLD DOCKER VOLUMES
docker volume prune

# DELETE OLD DOCKER NETWORKS (OPTIONAL: seems to restart fine without)
docker network prune

echo 'All Done ..Bye..'
exit 1
