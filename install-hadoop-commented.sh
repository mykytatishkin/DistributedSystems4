#!/bin/bash
###############################################################################
# Hadoop Single Node Setup - Installation Script
#
# This script performs the complete setup of a single-node Hadoop cluster:
# 1. Installs necessary packages
# 2. Sets up a dedicated Hadoop user
# 3. Configures SSH for passwordless authentication
# 4. Downloads and installs Hadoop
# 5. Configures Hadoop environment variables
# 6. Sets up Hadoop configuration files
# 7. Formats HDFS and starts Hadoop services
###############################################################################

# Don't exit on error for better Docker compatibility
# This allows the script to continue even if some commands fail
set +e

echo "########## Step 1: Installing Required Packages ##########"
# Update package repositories and install necessary software:
# - openjdk-8-jdk: Java required by Hadoop
# - wget: Used to download Hadoop
# - ssh: Required for Hadoop services to communicate
# - pdsh: Parallel distributed shell for cluster management
# - nano: Text editor for configuration files
apt-get update
apt-get install -y openjdk-8-jdk wget ssh pdsh nano

echo "########## Step 2: Verify Java Installation ##########"
# Check Java version to ensure it's properly installed
java -version
javac -version

echo "########## Step 3: Create a Dedicated Hadoop User ##########"
# Create a dedicated user for running Hadoop services
# This is a security best practice
adduser --gecos "" --disabled-password hadoop
echo "hadoop:hadoop" | chpasswd
usermod -aG sudo hadoop

echo "########## Step 4: Setting Up SSH Configuration ##########"
# Configure SSH for passwordless authentication between Hadoop services
# This allows Hadoop daemons to communicate without password prompts
mkdir -p /home/hadoop/.ssh
ssh-keygen -t rsa -P "" -f /home/hadoop/.ssh/id_rsa
cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys
chmod 0600 /home/hadoop/.ssh/authorized_keys
chown -R hadoop:hadoop /home/hadoop/.ssh

# Start SSH service
service ssh start || echo "Failed to start SSH service, but continuing..."

echo "########## Step 5: Download and Install Hadoop ##########"
# Download and extract Hadoop distribution
mkdir -p /home/hadoop/hadoop
cd /home/hadoop
wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz
tar -xzf hadoop-3.3.0.tar.gz
mv hadoop-3.3.0 /usr/local/hadoop
chown -R hadoop:hadoop /usr/local/hadoop

echo "########## Step 6: Configure Hadoop Environment Variables ##########"
# Add Hadoop environment variables to user's .bashrc file
cat >> /home/hadoop/.bashrc << 'EOL'
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
EOL

# Also add to /etc/profile for all users
cat >> /etc/profile << 'EOL'
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
EOL

# Apply the environment variables to current session
source /etc/profile

echo "########## Step 7: Configure Hadoop ##########"
# Create directories for temporary files
mkdir -p /app/hadoop/tmp
chown -R hadoop:hadoop /app/hadoop

# Configure core-site.xml - Contains NameNode location and HDFS configuration
cat > /usr/local/hadoop/etc/hadoop/core-site.xml << 'EOL'
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
EOL

# Configure hdfs-site.xml - Contains HDFS replication settings
cat > /usr/local/hadoop/etc/hadoop/hdfs-site.xml << 'EOL'
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
EOL

# Configure mapred-site.xml - Specifies MapReduce framework (YARN)
cat > /usr/local/hadoop/etc/hadoop/mapred-site.xml << 'EOL'
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
EOL

# Configure yarn-site.xml - Contains YARN resource manager settings
cat > /usr/local/hadoop/etc/hadoop/yarn-site.xml << 'EOL'
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
EOL

echo "########## Step 8: Format HDFS NameNode ##########"
# Format the HDFS filesystem (required before first use)
# This creates the directory structure for the HDFS filesystem
su - hadoop -c "cd /usr/local/hadoop && bin/hdfs namenode -format"

echo "########## Step 9: Start Hadoop Services ##########"
# Start HDFS (NameNode and DataNode)
su - hadoop -c "cd /usr/local/hadoop && sbin/start-dfs.sh"
# Start YARN (ResourceManager and NodeManager)
su - hadoop -c "cd /usr/local/hadoop && sbin/start-yarn.sh"

echo "########## Step 10: Verify Hadoop Services ##########"
echo "The following processes should be running:"
# jps lists all Java processes, including Hadoop daemons
su - hadoop -c "jps"

echo "########## Step 11: Accessing Web UIs ##########"
echo "NameNode UI: http://localhost:9870"
echo "ResourceManager UI: http://localhost:8088"
echo "DataNode UI: http://localhost:9864"

echo "########## Hadoop installation complete! ##########"

# Keep container running
tail -f /dev/null 