# Hadoop Distributed System Installation and Testing

## Student Information
- **Name:** [Your Name]
- **ID:** [Your Student ID]
- **Course:** Distributed Systems
- **Date:** [Submission Date]

## 1. Introduction

This report documents the process of installing and testing a single-node Hadoop distributed system. Apache Hadoop is an open-source framework that allows for distributed processing of large data sets across clusters of computers using simple programming models. The core components of Hadoop include:

- **Hadoop Distributed File System (HDFS)**: A distributed file system that provides high-throughput access to application data
- **YARN (Yet Another Resource Negotiator)**: A framework for job scheduling and cluster resource management
- **MapReduce**: A programming model for processing large data sets in parallel

For this assignment, I set up a single-node Hadoop cluster using Docker to simulate a complete Hadoop environment.

## 2. Environment Setup

### 2.1 System Information
- **Host Operating System:** macOS Sonoma 14.4.1
- **Docker Version:** [Docker version]
- **Java Version:** OpenJDK 8
- **Hadoop Version:** 3.3.0

### 2.2 Docker Configuration

I created a Docker environment to run Hadoop in an isolated container. This approach provides several advantages:
- Clean, isolated environment for Hadoop
- Ability to easily reset and restart the environment
- No interference with the host system

The Docker configuration consists of:
- A custom Dockerfile that defines the environment
- An installation script that sets up Hadoop
- Port mappings to access the Hadoop web interfaces

**Dockerfile:**
```dockerfile
# Include relevant portions of your Dockerfile here
```

**Installation Script:**
```bash
# Include relevant portions of your installation script here
```

## 3. Hadoop Installation Process

### 3.1 Creating the Docker Image

[Include screenshot of Docker build process]

### 3.2 Launching the Container

[Include screenshot of Docker run command and its output]

### 3.3 Installation Steps Inside the Container

The installation process inside the container included these key steps:

1. **Installing Required Packages:**
   - Java 8 JDK
   - SSH for inter-service communication
   - Other required tools
   
   [Include screenshot of package installation]

2. **Setting Up SSH Configuration:**
   - Configuring passwordless SSH for Hadoop services
   
   [Include screenshot of SSH setup]

3. **Downloading and Installing Hadoop:**
   - Downloading Hadoop 3.3.0
   - Extracting and configuring installation
   
   [Include screenshot of Hadoop download/installation]

4. **Configuring Hadoop Environment:**
   - Setting environment variables
   - Configuring XML files (core-site.xml, hdfs-site.xml, etc.)
   
   [Include screenshot of configuration files]

5. **Formatting HDFS NameNode:**
   - Initializing the HDFS filesystem
   
   [Include screenshot of HDFS formatting]

6. **Starting Hadoop Services:**
   - Starting HDFS (NameNode, DataNode)
   - Starting YARN (ResourceManager, NodeManager)
   
   [Include screenshot of service startup]

7. **Verifying Installation:**
   - Checking running processes with jps
   - Confirming services are operational
   
   [Include screenshot of jps output]

## 4. Web Interfaces

Hadoop provides several web interfaces to monitor and manage the cluster:

### 4.1 NameNode Web UI (http://localhost:9870)

[Include screenshot of NameNode UI]

The NameNode UI provides information about:
- HDFS health and statistics
- Available capacity and used space
- Block information and replication status
- Active datanodes

### 4.2 ResourceManager Web UI (http://localhost:8088)

[Include screenshot of ResourceManager UI]

The ResourceManager UI shows:
- Cluster resource usage
- Running applications
- Node health
- Application logs and history

### 4.3 DataNode Web UI (http://localhost:9864)

[Include screenshot of DataNode UI]

The DataNode UI displays:
- Local node storage information
- Block information
- Logs and metrics

## 5. MapReduce Examples

### 5.1 WordCount Example

The WordCount example is a classic MapReduce program that counts the occurrences of each word in a set of input files.

#### 5.1.1 Preparing Input Data

[Include screenshot of creating input files]

#### 5.1.2 Uploading Data to HDFS

[Include screenshot of HDFS commands]

#### 5.1.3 Running the WordCount Job

[Include screenshot of job execution]

#### 5.1.4 Viewing Results

[Include screenshot of output results]

**Analysis:**
The WordCount example demonstrates the power of MapReduce by breaking down the task into map and reduce phases:
- Map phase: Each mapper processes a portion of the input files and emits key-value pairs of <word, 1>
- Reduce phase: Reducers aggregate the counts for each word and produce the final output

### 5.2 Pi Calculation Example

The Pi calculation example uses a Monte Carlo method to estimate the value of Pi.

[Include screenshot of Pi example execution]

**Analysis:**
This example demonstrates:
- How MapReduce can be used for numerical computations
- The scalability of Hadoop for computationally intensive tasks
- How accuracy increases with more mappers and samples

## 6. Challenges and Solutions

During the installation and testing process, I encountered the following challenges:

1. **Challenge 1: [Description of challenge]**
   - Solution: [How you solved it]

2. **Challenge 2: [Description of challenge]**
   - Solution: [How you solved it]

## 7. Conclusion

The single-node Hadoop setup provides a valuable learning environment for understanding distributed systems concepts. Through this assignment, I gained insights into:

- The architecture of Hadoop and its core components
- How distributed file systems work (HDFS)
- The MapReduce programming model
- Resource management in distributed environments (YARN)

While a single-node setup is not suitable for processing large datasets in production, it effectively demonstrates the principles of distributed computing and provides a foundation for more complex multi-node configurations.

## 8. References

1. Apache Hadoop Documentation - https://hadoop.apache.org/docs/r3.3.0/
2. Hadoop: The Definitive Guide, 4th Edition - Tom White
3. Docker Documentation - https://docs.docker.com/
4. [Other references used in your work] 