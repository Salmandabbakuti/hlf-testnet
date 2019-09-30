set -ev

sudo rm -rf backup
mkdir backup
#Copying Certificates and Configuration files
sleep 5
cp -r crypto-config backup
cp -r channel-artifacts backup

cd backup
mkdir peer0.org1
mkdir peer0.org2
mkdir peer0.org3
mkdir orderer
cd ..
#Copying Peer and orderer data
sleep 5
sudo docker cp peer0.org1.example.com:/var/hyperledger/production/ backup/peer0.org1/
sudo docker cp peer0.org2.example.com:/var/hyperledger/production/ backup/peer0.org2/
sudo docker cp peer0.org3.example.com:/var/hyperledger/production/ backup/peer0.org3/

sudo docker cp orderer.example.com:/var/hyperledger/production/orderer/ backup/orderer/


#All done
exit 1
