#!/bin/bash -eu

source envPeerCompany.sh
peer lifecycle chaincode package basic.tar.gz --path chaincode --lang golang --label basic_1

source envPeerCompany.sh
peer lifecycle chaincode install basic.tar.gz
peer lifecycle chaincode queryinstalled

source envPeerSchool.sh
peer lifecycle chaincode install basic.tar.gz
peer lifecycle chaincode queryinstalled

source envPeerGroup.sh
peer lifecycle chaincode install basic.tar.gz
peer lifecycle chaincode queryinstalled