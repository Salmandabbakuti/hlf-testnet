echo 'Installing Chaincode  On All Peers..'

sudo docker exec -it cli3 peer chaincode install -n mycc -p github.com/chaincode -v v0

sudo docker exec -it cli2 peer chaincode install -n mycc -p github.com/chaincode -v v0

sudo docker exec -it cli peer chaincode install -n mycc -p github.com/chaincode -v v0

echo 'Instantiating Chaincode on mychannel..'

sudo docker exec -it cli peer chaincode instantiate -o orderer.example.com:7050 -C mychannel -n mycc github.com/chaincode -v v0 -c '{"Args": ["a", "100"]}'

echo 'Instantiating Chaincode on channel12..'

sudo docker exec -it cli peer chaincode instantiate -o orderer.example.com:7050 -C channel12 -n mycc github.com/chaincode -v v0 -c '{"Args": ["a", "100"]}'

echo 'All Done.. Start Invoking and Querying with *iq.sh* ..'

exit 1
