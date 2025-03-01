#!/bin/bash

# Exit script if any command fails
set -e

# Variables
GRAFANA_VERSION="11.5.2"
GRAFANA_TAR="grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz"
GRAFANA_URL="https://dl.grafana.com/oss/release/${GRAFANA_TAR}"
GRAFANA_DIR="/opt/grafana"
SERVICE_FILE="/etc/systemd/system/grafana.service"

# Download Grafana tarball
echo "Downloading Grafana version ${GRAFANA_VERSION}..."
wget -q "${GRAFANA_URL}"

# Extract Grafana
echo "Extracting Grafana..."
tar -zxvf "${GRAFANA_TAR}"

# Move Grafana to /opt
echo "Moving Grafana to ${GRAFANA_DIR}..."
sudo mv "grafana-${GRAFANA_VERSION}" "${GRAFANA_DIR}"

# Create systemd service file
echo "Creating systemd service..."
sudo bash -c "cat > ${SERVICE_FILE} <<EOL
[Unit]
Description=Grafana
After=network.target

[Service]
User=root
ExecStart=${GRAFANA_DIR}/bin/grafana-server web
WorkingDirectory=${GRAFANA_DIR}
Restart=always
LimitNOFILE=10000

[Install]
WantedBy=multi-user.target
EOL"

# Reload systemd, enable and start Grafana service
echo "Reloading systemd, enabling and starting Grafana..."
sudo systemctl daemon-reload
sudo systemctl enable grafana.service
sudo systemctl start grafana.service

# Check the status of the Grafana service
echo "Grafana installation complete. Checking service status..."
sudo systemctl status grafana.service