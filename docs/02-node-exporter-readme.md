## Setup Node-exporter to collect metrics
Node-exporter is a metrics collector fro UNIX-based kernels.

It collects data like CPU, MEM, DISK, N/W [node-exporter](https://prometheus.io/download/#node_exporter)

```
./node-exporter.sh
```

Run the node-exporter as a service
```
sudo tee /etc/systemd/system/node.service<<EOF
[Unit]
Description=Prometheus Node Exporter
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/var/lib/node/node_exporter

SyslogIdentifier=prometheus_node_exporter
Restart=always

[Install]
WantedBy=multi-user.target
EOF
```

Restart the deamon and start the service
```
sudo systemctl daemon-reload
sudo systemctl start node
sudo systemctl enable node
```

Expose the node  at prometheus.yml
```
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "node-exporter"
      static_configs:
        - targets: ["localhost:9100"]
```

Note:- Restart prometheus to apply the changes
```
sudo systemctl restart prometheus
```


----

Next: [Grafana](03-grafana-readme.md) <br/>
Previous: [Prometheus](01-prometheus-readme.md)