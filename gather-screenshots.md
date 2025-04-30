# Screenshot Guide for Hadoop Assignment

This document outlines all the screenshots you should take for your report. Organize them in the same order to make your report comprehensive.

## 1. Installation Process

### 1.1 Docker Build Process
Take a screenshot of running:
```
docker build -t hadoop-setup .
```

### 1.2 Docker Run Command
Take a screenshot of running:
```
docker run -d --name hadoop-node -p 9870:9870 -p 8088:8088 -p 9864:9864 hadoop-setup
```

### 1.3 Container Verification
Take a screenshot of running:
```
docker ps | grep hadoop
```

## 2. Hadoop Services Verification

### 2.1 Java Processes
Take a screenshot of running:
```
docker exec -it hadoop-node bash -c "jps"
```
This shows the running Hadoop services (NameNode, DataNode, ResourceManager, etc.)

## 3. Hadoop Web UIs

### 3.1 NameNode Web UI
Take a screenshot of http://localhost:9870 in your browser, showing:
- The overview page
- The datanodes information page
- The utilities menu

### 3.2 ResourceManager Web UI
Take a screenshot of http://localhost:8088 in your browser, showing:
- The cluster overview
- The nodes list
- The applications page (even if empty)

### 3.3 DataNode Web UI
Take a screenshot of http://localhost:9864 in your browser, showing:
- The datanode information

## 4. MapReduce Examples

Connect to the container to run examples:
```
docker exec -it hadoop-node bash
```

### 4.1 WordCount Example

#### 4.1.1 Creating Input Files
Take a screenshot showing:
```
mkdir -p ~/input
echo "Hello World Bye World" > ~/input/file1.txt
echo "Hello Hadoop Goodbye Hadoop" > ~/input/file2.txt
ls -la ~/input
cat ~/input/file1.txt
```

#### 4.1.2 Creating HDFS Directory
Take a screenshot showing:
```
hdfs dfs -mkdir -p /user/root/wordcount/input
```

#### 4.1.3 Uploading to HDFS
Take a screenshot showing:
```
hdfs dfs -put ~/input/* /user/root/wordcount/input
hdfs dfs -ls /user/root/wordcount/input
```

#### 4.1.4 Running WordCount
Take a screenshot showing the execution of:
```
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar wordcount /user/root/wordcount/input /user/root/wordcount/output
```

#### 4.1.5 Viewing Results
Take a screenshot showing:
```
hdfs dfs -ls /user/root/wordcount/output
hdfs dfs -cat /user/root/wordcount/output/part-r-00000
```

### 4.2 Pi Calculation Example

Take a screenshot showing the execution of:
```
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar pi 10 100
```

## 5. HDFS Commands

Take screenshots showing various HDFS commands:
```
hdfs dfs -ls /
hdfs dfs -mkdir /test
hdfs dfs -put ~/input/file1.txt /test
hdfs dfs -ls /test
hdfs dfs -cat /test/file1.txt
hdfs dfs -rm /test/file1.txt
hdfs dfs -rmdir /test
```

## 6. ResourceManager During Job Execution

While a MapReduce job is running, take a screenshot of the ResourceManager web UI showing the active application.

## 7. Job History

After completing MapReduce jobs, take a screenshot of the job history in the ResourceManager web UI.

## Organizing Screenshots

Name your screenshots logically, for example:
- 1-1-docker-build.png
- 1-2-docker-run.png
- 2-1-jps-output.png
- 3-1-namenode-ui.png
- 4-1-1-create-input.png

This will make it easier to include them in your report in the correct order. 