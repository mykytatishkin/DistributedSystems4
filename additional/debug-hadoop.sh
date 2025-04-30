#!/bin/bash

# This script debugs and fixes Hadoop setup issues

echo "===== Debugging Hadoop Setup ====="

# Check Java installation
echo "Checking Java installation:"
java -version

# Fix configuration files - force proper XML structure
echo "Fixing Hadoop configuration files..."

# Create proper core-site.xml
cat > /usr/local/hadoop/etc/hadoop/core-site.xml << 'EOF'
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/app/hadoop/tmp</value>
    </property>
</configuration>
EOF

# Create proper hdfs-site.xml
cat > /usr/local/hadoop/etc/hadoop/hdfs-site.xml << 'EOF'
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
EOF

# Create proper mapred-site.xml
cat > /usr/local/hadoop/etc/hadoop/mapred-site.xml << 'EOF'
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
EOF

# Create proper yarn-site.xml
cat > /usr/local/hadoop/etc/hadoop/yarn-site.xml << 'EOF'
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
EOF

# Ensure proper permissions
echo "Setting correct permissions..."
chown -R hadoop:hadoop /usr/local/hadoop
chown -R hadoop:hadoop /app/hadoop

# Ensure SSH service is running
echo "Starting SSH service..."
service ssh start

# Format HDFS namenode if needed
echo "Formatting HDFS namenode..."
su - hadoop -c "hdfs namenode -format -force"

# Stop any running services
echo "Stopping any running Hadoop services..."
su - hadoop -c "cd /usr/local/hadoop && sbin/stop-all.sh"

# Start Hadoop services
echo "Starting Hadoop services..."
su - hadoop -c "cd /usr/local/hadoop && sbin/start-dfs.sh"
su - hadoop -c "cd /usr/local/hadoop && sbin/start-yarn.sh"

# Verify running services
echo "Verifying Hadoop services:"
su - hadoop -c "jps"

# Ensure HDFS is accessible
echo "Testing HDFS access..."
su - hadoop -c "hdfs dfs -mkdir -p /user/hadoop/input"
su - hadoop -c "echo 'This is a test file' > /tmp/test.txt"
su - hadoop -c "hdfs dfs -put /tmp/test.txt /user/hadoop/input/"
su - hadoop -c "hdfs dfs -ls /user/hadoop/input"

echo "===== Setup Complete ====="
echo "You should now be able to access:"
echo "- NameNode UI: http://localhost:9870"
echo "- ResourceManager UI: http://localhost:8088"
echo "- DataNode UI: http://localhost:9864" 