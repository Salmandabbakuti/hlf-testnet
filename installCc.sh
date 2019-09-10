echo 'Installing Chaincode on Org1 Peer..'

sudo docker exec -it cli peer chaincode install -n ecom -p /opt/gopath/src/github.com/chaincode/ecom -v v0 -l "node" #installing chaincode on peer 0 via cli

echo 'Installing Chaincode on Org2 Peer..'

sudo docker exec -it cli2 peer chaincode install -n ecom -p /opt/gopath/src/github.com/chaincode/ecom -v v0 -l "node" #installing chaincode on peer 0 via cli

echo 'Installing Chaincode on Org3 Peer..'

sudo docker exec -it cli3 peer chaincode install -n ecom -p /opt/gopath/src/github.com/chaincode/ecom -v v0 -l "node" #installing chaincode on peer 0 via cli


echo 'Instantiating Chaincode on channel ...'

sudo docker exec -it cli peer chaincode instantiate -o orderer.example.com:7050 -C mychannel -n ecom /opt/gopath/src/github.com/chaincode/ecom -v v0 -c '{"Args": []}'
 
echo 'All Done.. You are Good to go.. Bye'

exit 1
