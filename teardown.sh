 
echo 'Clearing Network..'

echo 'Clearing  docker containers..'

sudo docker-compose -f docker-compose-cli.yaml down

# DELETE THE OLD DOCKER VOLUMES
sudo docker volume prune

# DELETE OLD DOCKER NETWORKS (OPTIONAL: seems to restart fine without)
sudo docker network prune

echo 'All Done ..Bye..'
exit 1
