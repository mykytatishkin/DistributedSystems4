#!/bin/bash
###############################################################################
# MapReduce Examples Tutorial Script
#
# This script demonstrates how to run MapReduce examples on Hadoop
# and collects all necessary information for your report
###############################################################################

echo "########## 1. Creating Test Data ##########"
# Create a directory for our test data
mkdir -p ~/input

# Create some sample text files with test data
echo "Creating sample input files..."
echo "Hello World Bye World" > ~/input/file1.txt
echo "Hello Hadoop Goodbye Hadoop" > ~/input/file2.txt
echo "Processing MapReduce Big Data Analytics" > ~/input/file3.txt
echo "Distributed Computing Systems Hadoop" > ~/input/file4.txt
echo "Sample data created in ~/input/"

echo "########## 2. Viewing the HDFS Filesystem ##########"
echo "Current HDFS directory structure:"
hdfs dfs -ls /

echo "########## 3. Creating HDFS Directories ##########"
echo "Creating directory for WordCount example..."
hdfs dfs -mkdir -p /user/root/wordcount/input
echo "HDFS directory created at /user/root/wordcount/input"

echo "########## 4. Copying Data to HDFS ##########"
echo "Copying input files to HDFS..."
hdfs dfs -put ~/input/* /user/root/wordcount/input
echo "Files copied to HDFS"

echo "########## 5. Verifying HDFS Data ##########"
echo "Listing files in HDFS input directory:"
hdfs dfs -ls /user/root/wordcount/input

echo "Viewing contents of the first input file:"
hdfs dfs -cat /user/root/wordcount/input/file1.txt

echo "########## 6. Running WordCount MapReduce Example ##########"
echo "Executing WordCount job..."
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar wordcount /user/root/wordcount/input /user/root/wordcount/output
echo "WordCount job completed"

echo "########## 7. Viewing WordCount Results ##########"
echo "Checking output directory:"
hdfs dfs -ls /user/root/wordcount/output

echo "Viewing word count results:"
hdfs dfs -cat /user/root/wordcount/output/part-r-00000

echo "########## 8. Running Pi Calculation Example ##########"
echo "Executing Pi calculation job..."
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar pi 10 100
echo "Pi calculation job completed"

echo "########## 9. Cleaning Up (Optional) ##########"
echo "To remove the output directory for rerunning the example, use:"
echo "hdfs dfs -rm -r /user/root/wordcount/output"

echo "########## MapReduce Examples Complete ##########"
echo ""
echo "Don't forget to take screenshots of:"
echo "1. The NameNode web UI (http://localhost:9870)"
echo "2. The ResourceManager web UI (http://localhost:8088)"
echo "3. The terminal showing MapReduce job execution"
echo "4. The output results"
echo ""
echo "These screenshots should be included in your report."> 