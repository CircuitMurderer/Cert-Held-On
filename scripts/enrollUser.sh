#!/bin/bash -eu

echo "Preparation============================="
mkdir -p $LOCAL_CA_PATH/council.seiun.net/assets
cp $LOCAL_CA_PATH/council.seiun.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/council.seiun.net/assets/ca-cert.pem
cp $LOCAL_CA_PATH/council.seiun.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/council.seiun.net/assets/tls-ca-cert.pem

mkdir -p $LOCAL_CA_PATH/company.seiun.net/assets
cp $LOCAL_CA_PATH/company.seiun.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/company.seiun.net/assets/ca-cert.pem
cp $LOCAL_CA_PATH/council.seiun.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/company.seiun.net/assets/tls-ca-cert.pem

mkdir -p $LOCAL_CA_PATH/school.seiun.net/assets
cp $LOCAL_CA_PATH/school.seiun.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/school.seiun.net/assets/ca-cert.pem
cp $LOCAL_CA_PATH/council.seiun.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/school.seiun.net/assets/tls-ca-cert.pem

mkdir -p $LOCAL_CA_PATH/group.seiun.net/assets
cp $LOCAL_CA_PATH/group.seiun.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/group.seiun.net/assets/ca-cert.pem
cp $LOCAL_CA_PATH/council.seiun.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/group.seiun.net/assets/tls-ca-cert.pem
echo "Preparation end=========================="

echo "Start Council============================="
echo "Enroll Admin"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/council.seiun.net/registers/admin1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin1:admin1@council.seiun.net:7050
# 加入通道时会用到admin/msp，其下必须要有admincers
mkdir -p $LOCAL_CA_PATH/council.seiun.net/registers/admin1/msp/admincerts
cp $LOCAL_CA_PATH/council.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/council.seiun.net/registers/admin1/msp/admincerts/cert.pem

echo "Enroll Orderer1"
# for identity
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/council.seiun.net/registers/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://orderer1:orderer1@council.seiun.net:7050
mkdir -p $LOCAL_CA_PATH/council.seiun.net/registers/orderer1/msp/admincerts
cp $LOCAL_CA_PATH/council.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/council.seiun.net/registers/orderer1/msp/admincerts/cert.pem
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.seiun.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://orderer1:orderer1@council.seiun.net:7050 --enrollment.profile tls --csr.hosts orderer1.council.seiun.net
cp $LOCAL_CA_PATH/council.seiun.net/registers/orderer1/tls-msp/keystore/*_sk $LOCAL_CA_PATH/council.seiun.net/registers/orderer1/tls-msp/keystore/key.pem

echo "Enroll Orderer2"
# for identity
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/council.seiun.net/registers/orderer2
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://orderer2:orderer2@council.seiun.net:7050
mkdir -p $LOCAL_CA_PATH/council.seiun.net/registers/orderer2/msp/admincerts
cp $LOCAL_CA_PATH/council.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/council.seiun.net/registers/orderer2/msp/admincerts/cert.pem
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.seiun.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://orderer2:orderer2@council.seiun.net:7050 --enrollment.profile tls --csr.hosts orderer2.council.seiun.net
cp $LOCAL_CA_PATH/council.seiun.net/registers/orderer2/tls-msp/keystore/*_sk $LOCAL_CA_PATH/council.seiun.net/registers/orderer2/tls-msp/keystore/key.pem

echo "Enroll Orderer3"
# for identity
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/council.seiun.net/registers/orderer3
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://orderer3:orderer3@council.seiun.net:7050
mkdir -p $LOCAL_CA_PATH/council.seiun.net/registers/orderer3/msp/admincerts
cp $LOCAL_CA_PATH/council.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/council.seiun.net/registers/orderer3/msp/admincerts/cert.pem
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.seiun.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://orderer3:orderer3@council.seiun.net:7050 --enrollment.profile tls --csr.hosts orderer3.council.seiun.net
cp $LOCAL_CA_PATH/council.seiun.net/registers/orderer3/tls-msp/keystore/*_sk $LOCAL_CA_PATH/council.seiun.net/registers/orderer3/tls-msp/keystore/key.pem

mkdir -p $LOCAL_CA_PATH/council.seiun.net/msp/admincerts
mkdir -p $LOCAL_CA_PATH/council.seiun.net/msp/cacerts
mkdir -p $LOCAL_CA_PATH/council.seiun.net/msp/tlscacerts
mkdir -p $LOCAL_CA_PATH/council.seiun.net/msp/users
cp $LOCAL_CA_PATH/council.seiun.net/assets/ca-cert.pem $LOCAL_CA_PATH/council.seiun.net/msp/cacerts/
cp $LOCAL_CA_PATH/council.seiun.net/assets/tls-ca-cert.pem $LOCAL_CA_PATH/council.seiun.net/msp/tlscacerts/
cp $LOCAL_CA_PATH/council.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/council.seiun.net/msp/admincerts/cert.pem
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/council.seiun.net/msp/config.yaml
echo "End council============================="

echo "Start company============================="
echo "Enroll User1"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/company.seiun.net/registers/user1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/company.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://user1:user1@company.seiun.net:7250

echo "Enroll Admin1"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/company.seiun.net/registers/admin1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/company.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin1:admin1@company.seiun.net:7250
mkdir -p $LOCAL_CA_PATH/company.seiun.net/registers/admin1/msp/admincerts
cp $LOCAL_CA_PATH/company.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/company.seiun.net/registers/admin1/msp/admincerts/cert.pem

echo "Enroll Peer1"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/company.seiun.net/registers/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/company.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://peer1:peer1@company.seiun.net:7250
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/company.seiun.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer1company:peer1company@council.seiun.net:7050 --enrollment.profile tls --csr.hosts peer1.company.seiun.net
cp $LOCAL_CA_PATH/company.seiun.net/registers/peer1/tls-msp/keystore/*_sk $LOCAL_CA_PATH/company.seiun.net/registers/peer1/tls-msp/keystore/key.pem
mkdir -p $LOCAL_CA_PATH/company.seiun.net/registers/peer1/msp/admincerts
cp $LOCAL_CA_PATH/company.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/company.seiun.net/registers/peer1/msp/admincerts/cert.pem

mkdir -p $LOCAL_CA_PATH/company.seiun.net/msp/admincerts
mkdir -p $LOCAL_CA_PATH/company.seiun.net/msp/cacerts
mkdir -p $LOCAL_CA_PATH/company.seiun.net/msp/tlscacerts
mkdir -p $LOCAL_CA_PATH/company.seiun.net/msp/users
cp $LOCAL_CA_PATH/company.seiun.net/assets/ca-cert.pem $LOCAL_CA_PATH/company.seiun.net/msp/cacerts/
cp $LOCAL_CA_PATH/company.seiun.net/assets/tls-ca-cert.pem $LOCAL_CA_PATH/company.seiun.net/msp/tlscacerts/
cp $LOCAL_CA_PATH/company.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/company.seiun.net/msp/admincerts/cert.pem

cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/company.seiun.net/msp/config.yaml
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/company.seiun.net/registers/user1/msp/config.yaml
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/company.seiun.net/registers/admin1/msp/config.yaml
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/company.seiun.net/registers/peer1/msp/config.yaml
echo "End company============================="

echo "Start school============================="
echo "Enroll User1"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/school.seiun.net/registers/user1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/school.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://user1:user1@school.seiun.net:7350
mkdir -p $LOCAL_CA_PATH/school.seiun.net/registers/user1/msp/admincerts

echo "Enroll Admin1"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/school.seiun.net/registers/admin1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/school.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin1:admin1@school.seiun.net:7350
mkdir -p $LOCAL_CA_PATH/school.seiun.net/registers/admin1/msp/admincerts
cp $LOCAL_CA_PATH/school.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/school.seiun.net/registers/admin1/msp/admincerts/cert.pem

echo "Enroll Peer1"
# for identity
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/school.seiun.net/registers/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/school.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://peer1:peer1@school.seiun.net:7350
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/school.seiun.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer1school:peer1school@council.seiun.net:7050 --enrollment.profile tls --csr.hosts peer1.school.seiun.net
cp $LOCAL_CA_PATH/school.seiun.net/registers/peer1/tls-msp/keystore/*_sk $LOCAL_CA_PATH/school.seiun.net/registers/peer1/tls-msp/keystore/key.pem
mkdir -p $LOCAL_CA_PATH/school.seiun.net/registers/peer1/msp/admincerts
cp $LOCAL_CA_PATH/school.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/school.seiun.net/registers/peer1/msp/admincerts/cert.pem

mkdir -p $LOCAL_CA_PATH/school.seiun.net/msp/admincerts
mkdir -p $LOCAL_CA_PATH/school.seiun.net/msp/cacerts
mkdir -p $LOCAL_CA_PATH/school.seiun.net/msp/tlscacerts
mkdir -p $LOCAL_CA_PATH/school.seiun.net/msp/users
cp $LOCAL_CA_PATH/school.seiun.net/assets/ca-cert.pem $LOCAL_CA_PATH/school.seiun.net/msp/cacerts/
cp $LOCAL_CA_PATH/school.seiun.net/assets/tls-ca-cert.pem $LOCAL_CA_PATH/school.seiun.net/msp/tlscacerts/
cp $LOCAL_CA_PATH/school.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/school.seiun.net/msp/admincerts/cert.pem

cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/school.seiun.net/msp/config.yaml
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/school.seiun.net/registers/user1/msp
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/school.seiun.net/registers/admin1/msp
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/school.seiun.net/registers/peer1/msp
echo "End school============================="

echo "Start group============================="
echo "Enroll User1"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/group.seiun.net/registers/user1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/group.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://user1:user1@group.seiun.net:7450
mkdir -p $LOCAL_CA_PATH/group.seiun.net/registers/user1/msp/admincerts

echo "Enroll Admin"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/group.seiun.net/registers/admin1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/group.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin1:admin1@group.seiun.net:7450
mkdir -p $LOCAL_CA_PATH/group.seiun.net/registers/admin1/msp/admincerts
cp $LOCAL_CA_PATH/group.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/group.seiun.net/registers/admin1/msp/admincerts/cert.pem

echo "Enroll Peer1"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/group.seiun.net/registers/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/group.seiun.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://peer1:peer1@group.seiun.net:7450
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/group.seiun.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer1group:peer1group@council.seiun.net:7050 --enrollment.profile tls --csr.hosts peer1.group.seiun.net
cp $LOCAL_CA_PATH/group.seiun.net/registers/peer1/tls-msp/keystore/*_sk $LOCAL_CA_PATH/group.seiun.net/registers/peer1/tls-msp/keystore/key.pem
mkdir -p $LOCAL_CA_PATH/group.seiun.net/registers/peer1/msp/admincerts
cp $LOCAL_CA_PATH/group.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/group.seiun.net/registers/peer1/msp/admincerts/cert.pem

mkdir -p $LOCAL_CA_PATH/group.seiun.net/msp/admincerts
mkdir -p $LOCAL_CA_PATH/group.seiun.net/msp/cacerts
mkdir -p $LOCAL_CA_PATH/group.seiun.net/msp/tlscacerts
mkdir -p $LOCAL_CA_PATH/group.seiun.net/msp/users
cp $LOCAL_CA_PATH/group.seiun.net/assets/ca-cert.pem $LOCAL_CA_PATH/group.seiun.net/msp/cacerts/
cp $LOCAL_CA_PATH/group.seiun.net/assets/tls-ca-cert.pem $LOCAL_CA_PATH/group.seiun.net/msp/tlscacerts/
cp $LOCAL_CA_PATH/group.seiun.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/group.seiun.net/msp/admincerts/cert.pem

cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/group.seiun.net/msp/config.yaml
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/group.seiun.net/registers/user1/msp
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/group.seiun.net/registers/admin1/msp
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/group.seiun.net/registers/peer1/msp
echo "End group============================="

find orgs/ -regex ".+cacerts.+.pem" -not -regex ".+tlscacerts.+" | rename 's/cacerts\/.+\.pem/cacerts\/ca-cert\.pem/'
