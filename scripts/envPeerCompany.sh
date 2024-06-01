export LOCAL_ROOT_PATH=$PWD
export LOCAL_CA_PATH=$LOCAL_ROOT_PATH/orgs
export DOCKER_CA_PATH=/tmp
export COMPOSE_PROJECT_NAME=seiun
export DOCKER_NETWORKS=network
export FABRIC_BASE_VERSION=2.4
export FABRIC_CA_VERSION=1.5

echo "init terminal company"
export FABRIC_CFG_PATH=$LOCAL_ROOT_PATH/config
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="companyMSP"
export CORE_PEER_ADDRESS=peer1.company.seiun.net:7251
export CORE_PEER_TLS_ROOTCERT_FILE=$LOCAL_CA_PATH/company.seiun.net/assets/tls-ca-cert.pem
export CORE_PEER_MSPCONFIGPATH=$LOCAL_CA_PATH/company.seiun.net/registers/admin1/msp
export ORDERER_CA=$LOCAL_CA_PATH/company.seiun.net/assets/tls-ca-cert.pem
