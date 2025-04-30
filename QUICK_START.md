# Hadoop Docker Setup - Quick Start Guide

This guide provides simplified steps to get your Hadoop environment running and complete your assignment.

## Setup Process

### 1. Build the Docker Image
```bash
docker build -t hadoop-setup .
```

### 2. Run the Hadoop Container
```bash
docker run -d --name hadoop-node -p 9870:9870 -p 8088:8088 -p 9864:9864 hadoop-setup
```

### 3. Verify Hadoop Services
```bash
docker exec -it hadoop-node bash -c "jps"
```
You should see: NameNode, DataNode, ResourceManager, NodeManager, and other Hadoop services running.

## Using Hadoop

### 1. Access Web Interfaces
- NameNode: http://localhost:9870
- ResourceManager: http://localhost:8088
- DataNode: http://localhost:9864

Take screenshots of these interfaces for your report.

### 2. Run MapReduce Examples
Copy the examples script to the container:
```bash
chmod +x copy-to-container.sh
./copy-to-container.sh
```

Connect to the container and run examples:
```bash
docker exec -it hadoop-node bash
bash /run-mapreduce-examples.sh
```

## Creating Your Report
Use the REPORT_TEMPLATE.md file as a starting point. Follow the guide in gather-screenshots.md to include all necessary screenshots.

## Cleaning Up
When you're done with the assignment:
```bash
chmod +x cleanup.sh
./cleanup.sh
```
Select the appropriate cleanup option from the menu. 