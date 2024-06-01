#!/bin/bash -eu

echo "Working on council"
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.seiun.net/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/council.seiun.net/ca/admin
fabric-ca-client enroll -d -u https://ca-admin:ca-adminpw@council.seiun.net:7050
fabric-ca-client register -d --id.name admin1 --id.secret admin1 --id.type admin -u https://council.seiun.net:7050
fabric-ca-client register -d --id.name orderer1 --id.secret orderer1 --id.type orderer -u https://council.seiun.net:7050
fabric-ca-client register -d --id.name orderer2 --id.secret orderer2 --id.type orderer -u https://council.seiun.net:7050
fabric-ca-client register -d --id.name orderer3 --id.secret orderer3 --id.type orderer -u https://council.seiun.net:7050
fabric-ca-client register -d --id.name peer1company --id.secret peer1company --id.type peer -u https://council.seiun.net:7050
fabric-ca-client register -d --id.name peer1school --id.secret peer1school --id.type peer -u https://council.seiun.net:7050
fabric-ca-client register -d --id.name peer1group --id.secret peer1group --id.type peer -u https://council.seiun.net:7050

echo "Working on company"
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/company.seiun.net/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/company.seiun.net/ca/admin
fabric-ca-client enroll -d -u https://ca-admin:ca-adminpw@company.seiun.net:7250
fabric-ca-client register -d --id.name user1 --id.secret user1 --id.type client -u https://company.seiun.net:7250
fabric-ca-client register -d --id.name peer1 --id.secret peer1 --id.type peer -u https://company.seiun.net:7250
fabric-ca-client register -d --id.name admin1 --id.secret admin1 --id.type admin -u https://company.seiun.net:7250

echo "Working on school"
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/school.seiun.net/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/school.seiun.net/ca/admin
fabric-ca-client enroll -d -u https://ca-admin:ca-adminpw@school.seiun.net:7350
fabric-ca-client register -d --id.name user1 --id.secret user1 --id.type client -u https://school.seiun.net:7350
fabric-ca-client register -d --id.name peer1 --id.secret peer1 --id.type peer -u https://school.seiun.net:7350
fabric-ca-client register -d --id.name admin1 --id.secret admin1 --id.type admin -u https://school.seiun.net:7350

echo "Working on group"
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/group.seiun.net/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/group.seiun.net/ca/admin
fabric-ca-client enroll -d -u https://ca-admin:ca-adminpw@group.seiun.net:7450
fabric-ca-client register -d --id.name user1 --id.secret user1 --id.type client -u https://group.seiun.net:7450
fabric-ca-client register -d --id.name peer1 --id.secret peer1 --id.type peer -u https://group.seiun.net:7450
fabric-ca-client register -d --id.name admin1 --id.secret admin1 --id.type admin -u https://group.seiun.net:7450

echo "All CA and registration done"
