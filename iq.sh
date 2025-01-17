echo 'Invoking Chaincode From Org1 Peer'

sudo docker exec -it cli peer chaincode invoke -o orderer.example.com:7050 -n mycc -c '{"Args":["set", "a", "20"]}' -C mychannel

sudo docker exec -it cli peer chaincode invoke -o orderer.example.com:7050 -n mycc -c '{"Args":["set", "a", "10"]}' -C channel12

sleep 5

echo 'Querying For Result on Org1 Peer'

sudo docker exec -it cli peer chaincode query -n mycc -c '{"Args":["query","a"]}' -C mychannel

sudo docker exec -it cli peer chaincode query -n mycc -c '{"Args":["query","a"]}' -C channel12

echo 'Invoking Chaincode From Org2 Peer'

sudo docker exec -it cli2 peer chaincode invoke -o orderer.example.com:7050 -n mycc -c '{"Args":["set", "a", "40"]}' -C mychannel

sudo docker exec -it cli2 peer chaincode invoke -o orderer.example.com:7050 -n mycc -c '{"Args":["set", "a", "30"]}' -C channel12

sleep 5

echo 'Querying For Result on Org2 Peer'

sudo docker exec -it cli2 peer chaincode query -n mycc -c '{"Args":["query","a"]}' -C mychannel

sudo docker exec -it cli2 peer chaincode query -n mycc -c '{"Args":["query","a"]}' -C channel12

echo 'Invoking Chaincode From Org3 Peer'

sudo docker exec -it cli3 peer chaincode invoke -o orderer.example.com:7050 -n mycc -c '{"Args":["set", "a", "60"]}' -C mychannel

sleep 5

echo 'Querying For Result on Org3 Peer'

sudo docker exec -it cli3 peer chaincode query -n mycc -c '{"Args":["query","a"]}' -C mychannel

echo 'All Done.. You are Awesome.. have a great day... bye..'

exit 1
