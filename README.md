# Puffer's Pass Deployment Guide

make sure to install nodejs first

then run `npm install -g hardhat` on terminal

download the folder and open it on vs code and open terminal there

download all dependencies using `npm install` on terminal of vscode

now after download rename the `.env.example` to `.env`

and paste following info there

```
PRIVATE_KEY = '0x....YOUR_PRIVATE_KEY'
ETHERSCAN_API_KEY  = 'POLYGON SCAN API KEY'
WEB3_INFURA_PROJECT_ID = 'INFURA NODE ID'
COINMARKETCAP_API_KEY = ''
IS_GAS_REPORTER_ENABLED = True
```

type following commands

`npx hardhat compile` to compile the code

`npx hardhat run scripts/deploy.js --network mumbai` to deploy on mumbai testnet

`npx hardhat verify <smart contract address> <constructor arguments> --network mumbai` to verify contract on polygonscan

commands will be the same for polygon network you just have to change mumbai to polygon
