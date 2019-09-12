# hlf-testnet
3 org single channel network for testing

### Steps

1. Download latest fabric tools and docker images

```

curl -sSL http://bit.ly/2ysbOFE | bash -s

```

>Note: Tested under 1.4.2

2. Generate Crypto certificates and channel artifacts

```
./generate.sh
```

3.Create Channel and join all peers to it

```
./start.sh
```

4.Install and Instantiating Chaincode

```
./installSacc.sh
```

5.Invoke and query Chaincode on all 3 peers

```
./iq.sh
```

6. Shutdown Network and clear Containers

```
./teardown.sh
```
### Wanted to Run Ecommerce Client Application??

```
cd client
./startEcom.sh
node server1.js //Operating from Org1 and Runs at port 8080
node server2.js // Operations from Org2 and Runs at port 8081
```
