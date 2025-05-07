# 🐳 ELK Stack + Flask Logging with Docker

This project sets up a full **ELK Stack** (Elasticsearch, Logstash, Kibana) using **Docker** and streams logs from a **Flask application** into Kibana for visualization.

## 🔍 What You'll Learn

- How to capture and structure logs from a Flask app
- Use Logstash to parse and forward logs
- Store and search logs in Elasticsearch
- Visualize data in Kibana — all containerized via Docker

---

## 🛠️ Tech Stack

- Python Flask
- Docker + Docker Compose
- ELK Stack (v7.17.9):
  - Elasticsearch
  - Logstash
  - Kibana

---

## 📁 Project Structure

.
├── docker-compose.yml
├── flask-app/
│ ├── app.py
│ └── Dockerfile
├── logstash/
│ └── logstash.conf
└── logs/
└── app.log

