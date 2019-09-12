### Adding An Organization To Running Network

#### Workflow

1.Fetch latest config block from network
```
peer channel fetch config config_block.pb -o orderer.example.com:7050 -c mychannel
```

2.Decode config block and extract Required Orgs information into Json(1)

```
 configtxlator proto_decode --input config_block.pb --type common.Block | jq .data.data[0].payload.data.config > config.json
```

3.Create new Oranization Config in json(of your choice)  (2)
```
export FABRIC_CFG_PATH=$PWD && configtxgen -printOrg Org4MSP > ../channel-artifacts/org4.json
```
4.Add (2) data into (1) using configtxlator jq and save as new file (2a)
```
jq -s '.[0] * {"channel_group":{"groups":{"Application":{"groups": {"Org4MSP":.[1]}}}}}' config.json ./channel-artifacts/org4.json > modified_config.json
```
5.Encode (1) and (2a) files into binary Proto buffs(3),(4)
```
configtxlator proto_encode --input config.json --type common.Config --output config.pb
configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb
```
6.Compute Delta(binary difference) between (3) and (4) and result is (5)

```
configtxlator compute_update --channel_id mychannel --original config.pb --updated modified_config.pb --output org4_update.pb
```
7.Decode (5) into json and add an json envelope to it resulting (6)
```
configtxlator proto_decode --input org4_update.pb --type common.ConfigUpdate | jq . > org4_update.json

echo '{"payload":{"header":{"channel_header":{"channel_id":"mychannel", "type":2}},"data":{"config_update":'$(cat org4_update.json)'}}}' | jq . > org4_update_in_envelope.json
```
8.Encode (6) back to protobuff (7)
```
configtxlator proto_encode --input org4_update_in_envelope.json --type common.Envelope --output org4_update_in_envelope.pb
```
9.Sign the block(7) by Endorsing peers and submit block to Orderer.
```
peer channel signconfigtx -f org4_update_in_envelope.pb

sudo docker cp cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/org4_update_in_envelope.pb .

sudo docker cp org4_update_in_envelope.pb cli2:/opt/gopath/src/github.com/hyperledger/fabric/peer/org4_update_in_envelope.pb

10.Orderer will Validates the block and sends back to commiting peers. This time it will not send block to Removed Org Peers..


#### Steps


### Removing Organization From Running Network

#### Workflow

1.Fetch latest config block from network

2.Decode config block into Json(1)

3.Remove Oranization (of your choice) Artifacts from Json and save as new file (2)

4.Encode (1) and (2) files into binary Proto buffs(3),(4)

5.Compute Delta(binary difference) between (3) and (4) and result is (5)

6.Decode (5) into json and add an json envelope to it resulting (6)

7.Encode (6) back to protobuff (7)

8.Sign the block(7) by Endorsing peers and submit block to Orderer.

9.Orderer will Validates the block and sends back to commiting peers. This time it will not send block to Removed Org Peers..

#### Steps
**Make Sure you are in CLI container or Peer Container.All These commands only work in Container**
```
docker exec -it cli bash
docker exec -it <Peer Container Name> bash

```

1.Fetch latest config block from network

```
peer channel fetch config config_block.pb -o orderer.example.com:7050 -c mychannel
```

2.Decode config block and extract Org Config info to Json

```
configtxlator proto_decode --input config_block.pb --type common.Block | jq .data.data[0].payload.data.config > config.json
```

3.Remove Oranization (of your choice) Artifacts from Json and save as new file (2)

```
jq 'del(.channel_group.groups.Application.groups.Org3MSP)' config.json > modified_config.json
```

4.Encode (1) and (2) files into binary Proto buffs(3),(4)
```
configtxlator proto_encode --input config.json --type common.Config --output config.pb

configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb
```

5.Compute Delta(binary difference) between (3) and (4) and result is (5)
```
configtxlator compute_update --channel_id mychannel --original config.pb --updated modified_config.pb --output update.pb
```

6.Decode (5) into json and add an json envelope to it resulting (6)

```
configtxlator proto_decode --input update.pb --type common.ConfigUpdate | jq . > update.json

echo '{"payload":{"header":{"channel_header":{"channel_id":"mychannel", "type":2}},"data":{"config_update":'$(cat update.json)'}}}' | jq . > update_in_envelope.json
```

7.Encode (6) back to protobuff (7)
```
configtxlator proto_encode --input update_in_envelope.json --type common.Envelope --output update_in_envelope.pb
```

8.Sign the block(7) by Endorsing peers and submit block to Orderer.

a.Signing Block By Org1 Peer and Sending to Org2 Peer..'
```
peer channel signconfigtx -f update_in_envelope.pb

sudo docker cp cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/update_in_envelope.pb .

sudo docker cp update_in_envelope.pb cli2:/opt/gopath/src/github.com/hyperledger/fabric/peer/update_in_envelope.pb
# Signing By Org2 Peer and Submitting Transaction
peer channel update -f update_in_envelope.pb -c mychannel -o orderer.example.com:7050

```
