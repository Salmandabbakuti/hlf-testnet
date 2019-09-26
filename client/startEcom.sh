cd ..
echo 'Initiating Network Creation..'
chmod a+x generate.sh
chmod a+x start.sh
chmod a+x installEcomCc.sh
./generate.sh
./start.sh
./installEcomCc.sh
cd client
echo 'Preparing Client Application..'
chmod a+x prereqs.sh
./prereqs.sh

exit 1
