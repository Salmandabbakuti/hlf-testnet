echo ' Bringing Network Up and Running...'

sudo docker-compose -f docker-compose-cli.yaml up -d

sleep 20
echo 'Channel Creation Taking Place..'

sudo docker exec -it cli peer channel create -o orderer.example.com:7050 /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -c mychannel -f ./channel-artifacts/channel.tx

sudo docker exec -it cli peer channel join -b mychannel.block

echo 'Exporting channel block to other Peer Containers..'

docker cp cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/mychannel.block .

docker cp mychannel.block cli2:/opt/gopath/src/github.com/hyperledger/fabric/peer/mychannel.block
docker cp mychannel.block cli3:/opt/gopath/src/github.com/hyperledger/fabric/peer/mychannel.block


echo 'Org2 Peer joining Channel..'


sudo docker exec -it cli2 peer channel join -b mychannel.block

echo 'Org3 Peer joining channel...'

sudo docker exec -it cli3 peer channel join -b mychannel.block


echo 'All Peers Joined channel..'

exit 1
