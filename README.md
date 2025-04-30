# Hadoop Docker Setup for Distributed Systems

This project provides a simplified way to set up a Hadoop environment using Docker for educational purposes. The setup includes HDFS and YARN, allowing you to run MapReduce jobs in a controlled environment.

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

## References

1. Apache Hadoop Documentation: https://hadoop.apache.org/docs/r3.3.0/
2. Docker Documentation: https://docs.docker.com/
3. Hadoop Single Node Setup: https://hadoop.apache.org/docs/r3.3.0/hadoop-project-dist/hadoop-common/SingleCluster.html
4. MapReduce Tutorial: https://hadoop.apache.org/docs/r3.3.0/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html 