cd ..
echo 'Initiating  Network Creation..'
echo 'Cleaning Containers..'
sudo docker-compose -f docker-compose-cli.yaml down
sudo docker volume prune
sudo docker network prune
chmod a+x generate.sh
chmod a+x start.sh
chmod a+x installCc.sh
./generate.sh
./start.sh
./installCc.sh
cd client
echo 'Preparing Client Application..'
chmod a+x prereqs.sh
./prereqs.sh

exit 1
