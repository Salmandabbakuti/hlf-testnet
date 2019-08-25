 
echo 'Clearing Network..'


sudo docker-compose -f docker-compose-cli.yaml down

sudo docker rm $(docker ps -a -q)

echo 'All Done ..Bye..'
exit 1
