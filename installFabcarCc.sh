
echo 'Packaging Chaincode on org1 '
sudo docker exec -it cli peer lifecycle chaincode package fabcar.tar.gz --path /opt/gopath/src/github.com/chaincode/fabcar  --lang "node" --label fabcar_1.0
echo 'Installing Chaincode on Org1 Peer..'
sudo docker exec -it cli peer lifecycle chaincode install fabcar.tar.gz #installing chaincode on peer 0 via cli

echo 'Packaging Chaincode to org2 '
sudo docker exec -it cli2 peer lifecycle chaincode package fabcar.tar.gz --path /opt/gopath/src/github.com/chaincode/fabcar  --lang "node" --label fabcar_1.0
echo 'Installing Chaincode on Org2 Peer..'
sudo docker exec -it cli2 peer lifecycle chaincode install fabcar.tar.gz #installing chaincode on org2 peer 0 via cli

echo 'Packaging Chaincode on org3 '
sudo docker exec -it cli3 peer lifecycle chaincode package fabcar.tar.gz --path /opt/gopath/src/github.com/chaincode/fabcar  --lang "node" --label fabcar_1.0
echo 'Installing Chaincode on Org3 Peer..'

sudo docker exec -it cli3 peer lifecycle chaincode install fabcar.tar.gz #installing chaincode on  org3 peer 0 via cli

echo 'Approving Chaincode on Orgs..'
sudo docker exec -it cli peer lifecycle chaincode approveformyorg -o orderer.example.com:7050 --channelID mychannel --name fabcar --version 1.0 --init-required --package-id fabcar_1.0:10a998d41163d9b45f34626568ad8ed84b482bf3c762f7bf2eaf2876eb901372 --sequence 1 --waitForEvent
sudo docker exec -it cli2 peer lifecycle chaincode approveformyorg -o orderer.example.com:7050 --channelID mychannel --name fabcar --version 1.0 --init-required --package-id fabcar_1.0:10a998d41163d9b45f34626568ad8ed84b482bf3c762f7bf2eaf2876eb901372 --sequence 1 --waitForEvent
sudo docker exec -it cli3 peer lifecycle chaincode approveformyorg -o orderer.example.com:7050 --channelID mychannel --name fabcar --version 1.0 --init-required --package-id fabcar_1.0:10a998d41163d9b45f34626568ad8ed84b482bf3c762f7bf2eaf2876eb901372 --sequence 1 --waitForEvent
 echo 'checking commit status..'
 sudo docker exec -it cli peer lifecycle chaincode checkcommitreadiness --channelID mychannel --name fabcar --peerAddresses peer0.org1.example.com:7051 --version 1.0 --sequence 1 --output json --init-required >&log.txt
sleep 2
echo 'commit chaincode on channel..'
sudo docker exec -it cli peer lifecycle chaincode commit -o orderer.example.com:7050 --channelID mychannel --name fabcar --peerAddresses peer0.org1.example.com:7051 peer0.org2.example.com:7051 peer0.org3.example.com:7051 --version 1.0 --sequence 1 --init-required
echo 'uncomment lines 30, 32 in start.sh to test invoke and query.'

echo 'Invoking Chaincode '
sudo docker exec -it cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n fabcar --peerAddresses peer0.org1.example.com:7051 --isInit -c '{"function":"initLedger","Args":[]}' 
echo 'Querying Chaincode..'
sudo docker exec -it cli peer chaincode query -C mychannel -n fabcar -c '{"function":"queryAllCars","Args":[]}'

echo 'All Done.. You are Good to go.. Bye'

exit 1
