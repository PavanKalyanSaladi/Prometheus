#!/bin/bash

sudo apt-get update

wget https://github.com/prometheus/node_exporter/releases/download/v1.9.0/node_exporter-1.9.0.linux-amd64.tar.gz

tar -xzvf node_exporter-1.9.0.linux-amd64.tar.gz

sudo groupadd --system promethues

sudo useradd -s /sbin/nologin --system -g prometheus prometheus

sudo mkdir -p /var/lib/node/

cd node_exporter-1.9.0.linux-amd64

sudo mv node_exporter /var/lib/node/

sudo chown -R prometheus:prometheus /var/lib/node

sudo chown -R prometheus:prometheus /var/lib/node/*

sudo chmod -R 775 /var/lib/node

sudo chmod -R 775 /var/lib/node/*