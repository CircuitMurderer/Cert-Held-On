echo "init terminal group"
export CORE_PEER_LOCALMSPID="groupMSP"
export CORE_PEER_ADDRESS=peer1.group.seiun.net:7451
export CORE_PEER_TLS_ROOTCERT_FILE=$LOCAL_CA_PATH/group.seiun.net/assets/tls-ca-cert.pem
export CORE_PEER_MSPCONFIGPATH=$LOCAL_CA_PATH/group.seiun.net/registers/admin1/msp
export ORDERER_CA=$LOCAL_CA_PATH/group.seiun.net/assets/tls-ca-cert.pem
