rm -rf crypto-config
rm -rf channel-artifacts
mkdir channel-artifacts
export PATH=${PWD}/bin:${PWD}:$PATH
export FABRIC_CFG_PATH=$PWD
echo 'Generating Certificates...'

cryptogen generate --config=crypto-config.yaml

configtxgen -profile ThreeOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel

echo 'All Done..'
