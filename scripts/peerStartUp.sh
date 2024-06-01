#!/bin/bash -eu

docker-compose -f $LOCAL_ROOT_PATH/compose/docker-compose.yaml up -d peer1.company.seiun.net peer1.school.seiun.net peer1.group.seiun.net 
docker-compose -f $LOCAL_ROOT_PATH/compose/docker-compose.yaml up -d orderer1.council.seiun.net orderer2.council.seiun.net orderer3.council.seiun.net
sleep 5

configtxgen -profile OrgsChannel -outputCreateChannelTx $LOCAL_ROOT_PATH/data/testchannel.tx -channelID testchannel
configtxgen -profile OrgsChannel -outputBlock $LOCAL_ROOT_PATH/data/testchannel.block -channelID testchannel

cp $LOCAL_ROOT_PATH/data/testchannel.block $LOCAL_CA_PATH/company.seiun.net/assets/
cp $LOCAL_ROOT_PATH/data/testchannel.block $LOCAL_CA_PATH/school.seiun.net/assets/
cp $LOCAL_ROOT_PATH/data/testchannel.block $LOCAL_CA_PATH/group.seiun.net/assets/

source envPeerCompany.sh
export ORDERER_ADMIN_TLS_SIGN_CERT=$LOCAL_CA_PATH/council.seiun.net/registers/orderer1/tls-msp/signcerts/cert.pem
export ORDERER_ADMIN_TLS_PRIVATE_KEY=$LOCAL_CA_PATH/council.seiun.net/registers/orderer1/tls-msp/keystore/key.pem
osnadmin channel join -o orderer1.council.seiun.net:7052 --channelID testchannel --config-block $LOCAL_ROOT_PATH/data/testchannel.block --ca-file "$ORDERER_CA" --client-cert "$ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$ORDERER_ADMIN_TLS_PRIVATE_KEY"
osnadmin channel list -o orderer1.council.seiun.net:7052 --ca-file $ORDERER_CA --client-cert $ORDERER_ADMIN_TLS_SIGN_CERT --client-key $ORDERER_ADMIN_TLS_PRIVATE_KEY
export ORDERER_ADMIN_TLS_SIGN_CERT=$LOCAL_CA_PATH/council.seiun.net/registers/orderer2/tls-msp/signcerts/cert.pem
export ORDERER_ADMIN_TLS_PRIVATE_KEY=$LOCAL_CA_PATH/council.seiun.net/registers/orderer2/tls-msp/keystore/key.pem
osnadmin channel join -o orderer2.council.seiun.net:7055 --channelID testchannel --config-block $LOCAL_ROOT_PATH/data/testchannel.block --ca-file "$ORDERER_CA" --client-cert "$ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$ORDERER_ADMIN_TLS_PRIVATE_KEY"
osnadmin channel list -o orderer2.council.seiun.net:7055 --ca-file $ORDERER_CA --client-cert $ORDERER_ADMIN_TLS_SIGN_CERT --client-key $ORDERER_ADMIN_TLS_PRIVATE_KEY
export ORDERER_ADMIN_TLS_SIGN_CERT=$LOCAL_CA_PATH/council.seiun.net/registers/orderer3/tls-msp/signcerts/cert.pem
export ORDERER_ADMIN_TLS_PRIVATE_KEY=$LOCAL_CA_PATH/council.seiun.net/registers/orderer3/tls-msp/keystore/key.pem
osnadmin channel join -o orderer3.council.seiun.net:7058 --channelID testchannel --config-block $LOCAL_ROOT_PATH/data/testchannel.block --ca-file "$ORDERER_CA" --client-cert "$ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$ORDERER_ADMIN_TLS_PRIVATE_KEY"
osnadmin channel list -o orderer3.council.seiun.net:7058 --ca-file $ORDERER_CA --client-cert $ORDERER_ADMIN_TLS_SIGN_CERT --client-key $ORDERER_ADMIN_TLS_PRIVATE_KEY

source envPeerCompany.sh
peer channel join -b $LOCAL_CA_PATH/company.seiun.net/assets/testchannel.block
peer channel list
source envPeerSchool.sh
peer channel join -b $LOCAL_CA_PATH/school.seiun.net/assets/testchannel.block
peer channel list
source envPeerGroup.sh
peer channel join -b $LOCAL_CA_PATH/group.seiun.net/assets/testchannel.block
peer channel list