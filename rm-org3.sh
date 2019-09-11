echo 'Removing Org3 From Network..'
sleep 3
echo 'Fetching Latest Block..'
sudo docker exec -it cli peer channel fetch config config_block.pb -o orderer.example.com:7050 -c mychannel

echo 'Decoding Block into json...'
sudo docker exec -it cli configtxlator proto_decode --input config_block.pb --type common.Block | jq .data.data[0].payload.data.config > config.json
sleep 3
echo 'Removing Org3 MSP from Configuration..'
sudo docker exec -it cli jq 'del(.channel_group.groups.Application.groups.Org3MSP)' config.json > modified_config.json
sleep 3
echo 'Encoding Before and After Json files..'
sudo docker exec -it cli configtxlator proto_encode --input config.json --type common.Config --output config.pb
sudo docker exec -it cli configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb
echo 'Computing Deltas of Two Protobuffs..'
sudo docker exec -it cli configtxlator compute_update --channel_id mychannel --original config.pb --updated modified_config.pb --output update.pb
sleep 5
echo 'Decoding and Adding Envelope and Encoding Back to final file ..'
sudo docker exec -it cli configtxlator proto_decode --input update.pb --type common.ConfigUpdate | jq . > update.json
sudo docker exec -it cli echo '{"payload":{"header":{"channel_header":{"channel_id":"mychannel", "type":2}},"data":{"config_update":'$(cat update.json)'}}}' | jq . > update_in_envelope.json
sudo docker exec -it cli configtxlator proto_encode --input update_in_envelope.json --type common.Envelope --output update_in_envelope.pb
sleep 5
echo 'Signing Block By Org1 Peer and Sending to Org2 Peer..'
sudo docker exec -it cli peer channel signconfigtx -f update_in_envelope.pb

sudo docker cp cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/update_in_envelope.pb .

sudo docker cp update_in_envelope.pb cli2:/opt/gopath/src/github.com/hyperledger/fabric/peer/update_in_envelope.pb

sleep 5
echo 'Signing and Submitting To Ordere to Include in Ledger ...'

sudo docker exec -it cli2 peer channel update -f update_in_envelope.pb -c mychannel -o orderer.example.com:7050

rm -rf config.json
rm -rf modified_config.json
rm -rf config_block.pb
rm -rf config.pb
rm -rf modified_config.pb
rm -rf update.pb
rm -rf update.json
rm -rf update_in_envelope.pb

echo 'All Done..'

exit 1
