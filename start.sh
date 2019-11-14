echo ' Bringing Network Up and Running...'

sudo docker-compose -f docker-compose-cli.yaml down
sudo docker volume prune
sudo docker network prune
sudo docker-compose -f docker-compose-cli.yaml up -d

sleep 20
echo 'Channel Creation Taking Place by Peer0..'

sudo docker exec -it cli peer channel create -o orderer.example.com:7050 /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -c mychannel -f ./channel-artifacts/channel.tx

sudo docker exec -it cli peer channel join -b mychannel.block

echo 'Exporting channel block to other Peer Containers..'

sudo docker cp cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/mychannel.block .

sudo docker cp mychannel.block cli2:/opt/gopath/src/github.com/hyperledger/fabric/peer/mychannel.block
sudo docker cp mychannel.block cli3:/opt/gopath/src/github.com/hyperledger/fabric/peer/mychannel.block
rm mychannel.block
echo ' Peer1 joining Channel..'


sudo docker exec -it cli2 peer channel join -b mychannel.block

echo 'Peer2 joining channel...'

sudo docker exec -it cli3 peer channel join -b mychannel.block


echo 'All Peers Joined mychannel..'

exit 1
