set -ev

#bringing network down and clearing volumes

sudo docker-compose -f docker-compose-cli.yaml down

sudo docker volume prune

sudo docker network prune

#Bringing network Up with Previous Backup

sudo docker-compose -f restore-network.yml up -d
#All done...
sleep 20

#querying Data

sudo docker exec -it cli peer chaincode query -n mycc -c '{"Args":["query","a"]}' -C mychannel
sudo docker exec -it cli2 peer chaincode query -n mycc -c '{"Args":["query","a"]}' -C mychannel
sudo docker exec -it cli3 peer chaincode query -n mycc -c '{"Args":["query","a"]}' -C mychannel



exit 1
