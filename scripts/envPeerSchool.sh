echo "init terminal school"
export CORE_PEER_LOCALMSPID="schoolMSP"
export CORE_PEER_ADDRESS=peer1.school.seiun.net:7351
export CORE_PEER_TLS_ROOTCERT_FILE=$LOCAL_CA_PATH/school.seiun.net/assets/tls-ca-cert.pem
export CORE_PEER_MSPCONFIGPATH=$LOCAL_CA_PATH/school.seiun.net/registers/admin1/msp
export ORDERER_CA=$LOCAL_CA_PATH/school.seiun.net/assets/tls-ca-cert.pem
