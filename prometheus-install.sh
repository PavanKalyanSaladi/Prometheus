#!/bin/bash

sudo apt-get update

wget https://github.com/prometheus/prometheus/releases/download/v3.2.1/prometheus-3.2.1.linux-amd64.tar.gz

sudo groupadd --system promethues

sudo useradd -s /sbin/nologin --system -g prometheus prometheus

sudo mkdir /var/lib/prometheus

sudo mkdir -p /etc/prometheus/rules

sudo mkdir -p /etc/prometheus/rules.s

sudo mkdir -p /etc/prometheus/files_sd

sudo tar -xzvf prometheus-3.2.1.linux-amd64.tar.gz

cd prometheus-3.2.1.linux-amd64

sudo mv prometheus promtool /usr/local/bin

sudo mv prometheus.yml /etc/prometheus/prometheus.yml

sudo chown -R prometheus:prometheus /etc/prometheus

sudo chown -R prometheus:prometheus /etc/prometheus/*

sudo chown -R prometheus:prometheus /var/lib/prometheus

sudo chmod -R 775 /etc/prometheus

sudo chmod -R 775 /etc/prometheus/*