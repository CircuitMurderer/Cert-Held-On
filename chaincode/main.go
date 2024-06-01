package main

import (
	"log"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
	"SEIUN/chaincode/cc"
)


func main() {
	cc, err := contractapi.NewChaincode(&cc.SmartContract{})
	if err != nil {
		log.Panicf("Failed to create chaincode: %v", err)
	}
	
	if err = cc.Start(); err != nil {
		log.Panicf("Failed to start chaincode: %v", err)
	}
}
