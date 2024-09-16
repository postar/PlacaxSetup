#!bin/bash

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

apt-get -qq -y update
apt-get -qq -y upgrade
apt-get -qq -y dist-upgrade
apt-get -qq -y --fix-broken install
apt-get -qq -y autoremove
docker compose -f /var/local/mesy-reports/setup/docker-compose.yml restart