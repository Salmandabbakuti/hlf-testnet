rm -rf crypto-config
rm -rf channel-artifacts
mkdir channel-artifacts
export PATH=${PWD}/bin:${PWD}:$PATH
export FABRIC_CFG_PATH=$PWD
CURRENT_DIR=$PWD
cd crypto-config/peerOrganizations/org1.example.com/ca/
PRIV_KEY11=$(ls *_sk)
cd $CURRENT_DIR
cd crypto-config/peerOrganizations/org2.example.com/ca/
PRIV_KEY12=$(ls *_sk)
cd $CURRENT_DIR
cd crypto-config/peerOrganizations/org3.example.com/ca/
PRIV_KEY13=$(ls *_sk)

sed -i "s/${PRIV_KEY11}/CA1_PRIVATE_KEY/g" docker-compose-kafka.yml
sed -i "s/${PRIV_KEY12}/CA2_PRIVATE_KEY/g" docker-compose-kafka.yml
sed -i "s/${PRIV_KEY13}/CA3_PRIVATE_KEY/g" docker-compose-kafka.yml


echo 'Generating Certificates...'

cryptogen generate --config=crypto-config.yaml

configtxgen -profile ThreeOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel

sleep 5
echo 'Setting up CA Containers'
CURRENT_DIR=$PWD
cd crypto-config/peerOrganizations/org1.example.com/ca/
PRIV_KEY1=$(ls *_sk)
cd $CURRENT_DIR
cd crypto-config/peerOrganizations/org2.example.com/ca/
PRIV_KEY2=$(ls *_sk)
cd $CURRENT_DIR
cd crypto-config/peerOrganizations/org3.example.com/ca/
PRIV_KEY3=$(ls *_sk)

cd $CURRENT_DIR
sed -i "s/CA1_PRIVATE_KEY/${PRIV_KEY1}/g" docker-compose-kafka.yml
sed -i "s/CA2_PRIVATE_KEY/${PRIV_KEY2}/g" docker-compose-kafka.yml
sed -i "s/CA3_PRIVATE_KEY/${PRIV_KEY3}/g" docker-compose-kafka.yml


echo 'All Done..'
