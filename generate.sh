rm -rf channel-artifacts
mkdir channel-artifacts
export PATH=${PWD}/bin:${PWD}:$PATH
export FABRIC_CFG_PATH=$PWD
CURRENT_DIR=$PWD
cd crypto-config/peerOrganizations/org1.example.com/ca/
PRIV_KEY11=$(ls *_sk)
cd $CURRENT_DIR

sed -i "s/${PRIV_KEY11}/CA1_PRIVATE_KEY/g" docker-compose-cli.yaml
rm -rf crypto-config

echo 'Generating Certificates...'

cryptogen generate --config=crypto-config.yaml

configtxgen -profile OneOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
configtxgen -profile channelAll -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel

sleep 5
echo 'Setting up CA Containers'
cd crypto-config/peerOrganizations/org1.example.com/ca/
PRIV_KEY1=$(ls *_sk)
cd $CURRENT_DIR

sed -i "s/CA1_PRIVATE_KEY/${PRIV_KEY1}/g" docker-compose-cli.yaml

echo 'All Done...'
