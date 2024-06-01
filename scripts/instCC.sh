#!/bin/bash -eu

source ./scripts/envPeerCompany.sh
peer lifecycle chaincode package basic.tar.gz --path chaincode --lang golang --label basic_1

source ./scripts/envPeerCompany.sh
peer lifecycle chaincode install basic.tar.gz
peer lifecycle chaincode queryinstalled

source ./scripts/envPeerSchool.sh
peer lifecycle chaincode install basic.tar.gz
peer lifecycle chaincode queryinstalled

source ./scripts/envPeerGroup.sh
peer lifecycle chaincode install basic.tar.gz
peer lifecycle chaincode queryinstalled