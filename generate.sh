rm -rf crypto-config
rm -rf channel-artifacts
mkdir channel-artifacts
export FABRIC_CFG_PATH=$PWD
echo 'Generating Certificates...'
../bin/configtxgen -profile ThreeOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
../bin/configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel

echo 'All Done..'
