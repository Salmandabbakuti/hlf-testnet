### Removing Organization From Running Network

#### Workflow

1.Fetch latest config block from network

2.Decode config block into Json(1)

3.Remove Oranization (of your choice) Artifacts from Json and save as new file (2)

4.Encode (1) and (2) files into binary Proto buffs(3),(4)

5.Compute Delta(binary difference) between (3) and (4) and result is (5)

6.Decode (5) into json and add an json envelope to it resulting (6)

7.Encode (6) back to protobuff (7)

8.Sign the block by Endorsing peers and submit block to Orderer.

9.Orderer will Validates the block and sends back to commiting peers. This time it will not send block to Removed Org Peers..
