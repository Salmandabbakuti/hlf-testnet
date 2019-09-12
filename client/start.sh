cd ..
echo 'Cloning test-net..'

git clone https://github.com/Salmandabbakuti/hlf-testnet.git

echo 'Mounting Chaincode..'
cd hlf-testnet
rm -rf chaincode
cd ..
cp -r chaincode hlf-testnet
echo 'Initiating  Network Creation..'
cd hlf-testnet
echo 'Cleaning Containers..'
sudo docker-compose -f docker-compose-cli.yaml down
sudo docker volume prune
sudo docker network prune
chmod a+x generate.sh
chmod a+x start.sh
chmod a+x installCc.sh
./generate.sh
./start.sh
./installCc.sh
cd ..
cd client
chmod a+x prereqs.sh
./prereqs.sh

exit 1
