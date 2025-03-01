# Mastering Prometheus and Grafana

[![Course Image](https://img-c.udemycdn.com/course/750x422/4181378_1d2a_3.jpg)](https://www.udemy.com/course/mastering-prometheus-and-grafana/?referralCode=C929F0178B24DAD1F809)

Welcome to the Mastering Prometheus and Grafana course! This course is designed to teach you about Prometheus and Grafana, two powerful tools commonly used for monitoring and visualization in modern IT environments.

## About the Course

In this course, you'll learn:

- How do you set up Prometheus to monitor various metrics in your infrastructure?
- How do you configure and use Grafana to visualize data collected by Prometheus?
- Best practices for monitoring and alerting using Prometheus and Grafana.
- Advanced topics such as scaling Prometheus and integrating it with other tools.
- Full course of Grafana.
- Full course of Grafna Loki.

## Why Learn Prometheus and Grafana?

Prometheus and Grafana have become industry standards for monitoring and visualization due to their flexibility, scalability, and powerful features. Mastering these tools effectively allows you to monitor and troubleshoot complex systems.

## Get Started
Download the prometheus tar from [prometheus](https://prometheus.io/download/)

```
./prometheus-install.sh
```

Run the prometheus as a service
```
sudo tee /etc/systemd/system/prometheus.service<<EOF
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.external-url=

SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target
EOF
```

```
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
```

Access promethues web server - localhost:9090


-----

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