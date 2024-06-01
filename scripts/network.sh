#!/bin/bash -u

networkUp() {
    docker-compose -f $LOCAL_ROOT_PATH/compose/docker-compose.yaml up -d council.seiun.net company.seiun.net school.seiun.net group.seiun.net
}

networkDown() {
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
    docker rmi $(docker images dev-* -q)
    rm -rf orgs data
}

while getopts 'ud' OPT; do
    case $OPT in
    u) networkUp ;;
    d) networkDown ;;
    ?) echo "use -u to up, -d to down." ;;
    esac
done
