#!/bin/bash

addDNS() {
    cp /etc/hosts /etc/hosts.bak

    echo "127.0.0.1       council.seiun.net" >>/etc/hosts
    echo "127.0.0.1       company.seiun.net" >>/etc/hosts
    echo "127.0.0.1       school.seiun.net" >>/etc/hosts
    echo "127.0.0.1       group.seiun.net" >>/etc/hosts

    echo "127.0.0.1       orderer1.council.seiun.net" >>/etc/hosts
    echo "127.0.0.1       orderer2.council.seiun.net" >>/etc/hosts
    echo "127.0.0.1       orderer3.council.seiun.net" >>/etc/hosts

    echo "127.0.0.1       peer1.company.seiun.net" >>/etc/hosts
    echo "127.0.0.1       peer1.school.seiun.net" >>/etc/hosts
    echo "127.0.0.1       peer1.group.seiun.net" >>/etc/hosts
}

setDNS() {
    cat /etc/hosts | grep seiun
    if [ $? -eq 1 ]; then
        addDNS
        echo "Done."
    else
        echo "DNS has already been set."
    fi
}

restoreDNS() {
    mv /etc/hosts.bak /etc/hosts
}

while getopts 'ad' OPT; do
    case $OPT in
    a) setDNS ;;
    d) restoreDNS ;;
    ?) echo "use -a to add, -d to delete." ;;
    esac
done
