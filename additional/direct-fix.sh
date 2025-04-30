#!/bin/bash

# This script uses direct echo commands to fix Hadoop configuration

echo "===== Direct Configuration Fix ====="

# Fix core-site.xml
echo "<configuration>" > /usr/local/hadoop/etc/hadoop/core-site.xml
echo "    <property>" >> /usr/local/hadoop/etc/hadoop/core-site.xml
echo "        <name>fs.defaultFS</name>" >> /usr/local/hadoop/etc/hadoop/core-site.xml
echo "        <value>hdfs://localhost:9000</value>" >> /usr/local/hadoop/etc/hadoop/core-site.xml
echo "    </property>" >> /usr/local/hadoop/etc/hadoop/core-site.xml
echo "    <property>" >> /usr/local/hadoop/etc/hadoop/core-site.xml
echo "        <name>hadoop.tmp.dir</name>" >> /usr/local/hadoop/etc/hadoop/core-site.xml
echo "        <value>/app/hadoop/tmp</value>" >> /usr/local/hadoop/etc/hadoop/core-site.xml
echo "    </property>" >> /usr/local/hadoop/etc/hadoop/core-site.xml
echo "</configuration>" >> /usr/local/hadoop/etc/hadoop/core-site.xml

# Fix hdfs-site.xml
echo "<configuration>" > /usr/local/hadoop/etc/hadoop/hdfs-site.xml
echo "    <property>" >> /usr/local/hadoop/etc/hadoop/hdfs-site.xml
echo "        <name>dfs.replication</name>" >> /usr/local/hadoop/etc/hadoop/hdfs-site.xml
echo "        <value>1</value>" >> /usr/local/hadoop/etc/hadoop/hdfs-site.xml
echo "    </property>" >> /usr/local/hadoop/etc/hadoop/hdfs-site.xml
echo "</configuration>" >> /usr/local/hadoop/etc/hadoop/hdfs-site.xml

# Fix mapred-site.xml
echo "<configuration>" > /usr/local/hadoop/etc/hadoop/mapred-site.xml
echo "    <property>" >> /usr/local/hadoop/etc/hadoop/mapred-site.xml
echo "        <name>mapreduce.framework.name</name>" >> /usr/local/hadoop/etc/hadoop/mapred-site.xml
echo "        <value>yarn</value>" >> /usr/local/hadoop/etc/hadoop/mapred-site.xml
echo "    </property>" >> /usr/local/hadoop/etc/hadoop/mapred-site.xml
echo "</configuration>" >> /usr/local/hadoop/etc/hadoop/mapred-site.xml

# Fix yarn-site.xml
echo "<configuration>" > /usr/local/hadoop/etc/hadoop/yarn-site.xml
echo "    <property>" >> /usr/local/hadoop/etc/hadoop/yarn-site.xml
echo "        <name>yarn.nodemanager.aux-services</name>" >> /usr/local/hadoop/etc/hadoop/yarn-site.xml
echo "        <value>mapreduce_shuffle</value>" >> /usr/local/hadoop/etc/hadoop/yarn-site.xml
echo "    </property>" >> /usr/local/hadoop/etc/hadoop/yarn-site.xml
echo "</configuration>" >> /usr/local/hadoop/etc/hadoop/yarn-site.xml

# Format namenode and restart services
echo "Formatting NameNode..."
su - hadoop -c "hdfs namenode -format -force"

echo "Restarting Hadoop services..."
su - hadoop -c "cd /usr/local/hadoop && sbin/stop-all.sh"
sleep 5
su - hadoop -c "cd /usr/local/hadoop && sbin/start-dfs.sh"
su - hadoop -c "cd /usr/local/hadoop && sbin/start-yarn.sh"

# Check services
echo "Checking Hadoop services:"
su - hadoop -c "jps" 