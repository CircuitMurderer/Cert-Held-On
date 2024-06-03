echo "init terminal company"
export CORE_PEER_LOCALMSPID="companyMSP"
export CORE_PEER_ADDRESS=peer1.company.seiun.net:7251
export CORE_PEER_TLS_ROOTCERT_FILE=$LOCAL_CA_PATH/company.seiun.net/assets/tls-ca-cert.pem
export CORE_PEER_MSPCONFIGPATH=$LOCAL_CA_PATH/company.seiun.net/registers/admin1/msp
export ORDERER_CA=$LOCAL_CA_PATH/company.seiun.net/assets/tls-ca-cert.pem
