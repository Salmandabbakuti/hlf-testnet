echo 'Installing Chaincode on Org1 Peer..'

sudo docker exec -it cli peer chaincode install -n mycc -p github.com/chaincode -v v0  #installing chaincode on peer 0 via cli

echo 'Installing Chaincode on Org2 Peer..'

sudo docker exec -it cli2 peer chaincode install -n mycc -p github.com/chaincode -v v0  #installing chaincode on peer 0 via cli

echo 'Installing Chaincode on Org3 Peer..'

sudo docker exec -it cli3 peer chaincode install -n mycc -p github.com/chaincode -v v0  #installing chaincode on peer 0 via cli


echo 'Instantiating Chaincode on channel ...'

sudo docker exec -it cli peer chaincode instantiate -o orderer.example.com:7050 -C mychannel -n mycc github.com/chaincode -v v0 -c '{"Args": ["a", "100"]}'
 
echo 'All Done.. You're Good to go.. Bye'

exit 1
