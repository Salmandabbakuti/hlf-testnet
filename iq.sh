echo 'Invoking Chaincode From Peer0'

sudo docker exec -it cli peer chaincode invoke -o orderer.example.com:7050 -n mycc -c '{"Args":["set", "a", "20"]}' -C mychannel
sleep 5

echo 'Querying For Result on  Peer0'

sudo docker exec -it cli peer chaincode query -n mycc -c '{"Args":["query","a"]}' -C mychannel
echo 'Invoking Chaincode From  Peer1'

sudo docker exec -it cli2 peer chaincode invoke -o orderer.example.com:7050 -n mycc -c '{"Args":["set", "a", "40"]}' -C mychannel
sleep 5

echo 'Querying For Result on Peer1'

sudo docker exec -it cli2 peer chaincode query -n mycc -c '{"Args":["query","a"]}' -C mychannel

echo 'Invoking Chaincode From  Peer2'

sudo docker exec -it cli3 peer chaincode invoke -o orderer.example.com:7050 -n mycc -c '{"Args":["set", "a", "60"]}' -C mychannel

sleep 5

echo 'Querying For Result on Org3 Peer2'

sudo docker exec -it cli3 peer chaincode query -n mycc -c '{"Args":["query","a"]}' -C mychannel

echo 'All Done.. You are Awesome.. have a great day... bye..'

exit 1
