echo 'Installing Chaincode on Org1 Peer..'

sudo docker exec -it cli peer chaincode install -n acl -p /opt/gopath/src/github.com/chaincode/acl -v v0 -l "node" #installing chaincode on peer 0 via cli

echo 'Installing Chaincode on Org2 Peer..'

sudo docker exec -it cli2 peer chaincode install -n acl -p /opt/gopath/src/github.com/chaincode/acl -v v0 -l "node" #installing chaincode on peer 0 via cli

echo 'Installing Chaincode on Org3 Peer..'

sudo docker exec -it cli3 peer chaincode install -n acl -p /opt/gopath/src/github.com/chaincode/acl -v v0 -l "node" #installing chaincode on peer 0 via cli


echo 'Instantiating Chaincode on channel ...'

sudo docker exec -it cli peer chaincode instantiate -o orderer.example.com:7050 -C mychannel -n acl /opt/gopath/src/github.com/chaincode/acl -v v0 -c '{"Args":["Init","salman279","12345","SalmanDev","+915487389277"]}'
 
echo 'All Done.. You are Good to go.. Bye'

exit 1
