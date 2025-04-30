# Hadoop Docker Setup for Distributed Systems

This project provides a simplified way to set up a Hadoop environment using Docker for educational purposes. The setup includes HDFS and YARN, allowing you to run MapReduce jobs in a controlled environment.

## Quick Start

For simplified instructions, see [QUICK_START.md](QUICK_START.md).

## What's Included

- `Dockerfile`: Defines the Hadoop environment
- `install-hadoop.sh`: Script for installing Hadoop components
- `install-hadoop-commented.sh`: Same script with detailed comments
- `run-mapreduce-examples.sh`: Script to run example MapReduce jobs
- `copy-to-container.sh`: Utility to copy files to the Docker container
- `cleanup.sh`: Script to clean up resources when you're done
- `REPORT_TEMPLATE.md`: Template for your assignment report
- `gather-screenshots.md`: Guide for gathering required screenshots

## Installation Process

1. Build the Docker image:
   ```bash
   docker build -t hadoop-setup .
   ```

2. Run the Hadoop container:
   ```bash
   docker run -d --name hadoop-node -p 9870:9870 -p 8088:8088 -p 9864:9864 hadoop-setup
   ```

3. Verify the services are running:
   ```bash
   docker exec -it hadoop-node bash -c "jps"
   ```

## Cleaning Up

The `cleanup.sh` script helps you manage resources used by this project. It can:

- Stop and remove the Hadoop container
- Remove the Docker image
- Delete temporary files created during testing
- Optionally remove screenshots

### Using the Cleanup Script

1. Make the script executable:
   ```bash
   chmod +x cleanup.sh
   ```

2. Run the script:
   ```bash
   ./cleanup.sh
   ```

3. Use the menu to select what you want to clean up:
   - Option 1: Stop the Hadoop container
   - Option 2: Remove the Hadoop container
   - Option 3: Remove the Hadoop Docker image
   - Option 4: Remove temporary files (with optional screenshot removal)
   - Option 5: Full cleanup (all of the above)
   - Option 0: Exit without doing anything

## Web Interfaces

- HDFS NameNode: http://localhost:9870
- YARN ResourceManager: http://localhost:8088
- DataNode: http://localhost:9864

## Assignment Submission

Follow the instructions in `REPORT_TEMPLATE.md` and `gather-screenshots.md` to complete your assignment.

## Project Structure

- `Dockerfile`: Defines the Docker image for the Hadoop environment
- `Dockerfile-commented`: Commented version of the Dockerfile with detailed explanations
- `install-hadoop.sh`: Script to set up Hadoop inside the Docker container
- `install-hadoop-commented.sh`: Commented version of the installation script with detailed explanations
- `run-mapreduce-examples.sh`: Script to run MapReduce examples
- `REPORT_TEMPLATE.md`: Template for the final report
- `gather-screenshots.md`: Guide for taking screenshots for the report
- `README.md`: This file

## Prerequisites

- Docker installed on your system
- At least 4GB of RAM available for Docker
- Internet connection to download Hadoop

## Detailed Instructions

For detailed steps, follow these guides:

1. Review the commented Dockerfile and installation script to understand the setup process
2. Use the `gather-screenshots.md` guide to document your progress
3. Complete each example in the `run-mapreduce-examples.sh` script
4. Use the `REPORT_TEMPLATE.md` to create your final report

## Troubleshooting

- If the container fails to start, check Docker logs:
  ```
  docker logs hadoop-node
  ```

- If Hadoop services aren't running, connect to the container and check:
  ```
  docker exec -it hadoop-node bash
  jps
  ```

- If Web UIs are not accessible, ensure ports are correctly mapped:
  ```
  docker port hadoop-node
  ```

## References

1. Apache Hadoop Documentation: https://hadoop.apache.org/docs/r3.3.0/
2. Docker Documentation: https://docs.docker.com/
3. Hadoop Single Node Setup: https://hadoop.apache.org/docs/r3.3.0/hadoop-project-dist/hadoop-common/SingleCluster.html
4. MapReduce Tutorial: https://hadoop.apache.org/docs/r3.3.0/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html 