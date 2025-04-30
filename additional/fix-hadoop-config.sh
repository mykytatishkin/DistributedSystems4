#!/bin/bash

# Run this script inside the container to fix the configuration issues

# Show the current content of a config file
echo "Before fix, showing core-site.xml:"
grep -A 5 "<property>" /usr/local/hadoop/etc/hadoop/core-site.xml

# Fix the config files (without relying on sed replacements)
# Instead, we'll create new correct files directly

# Create correct core-site.xml
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

# Create correct hdfs-site.xml
cat > /usr/local/hadoop/etc/hadoop/hdfs-site.xml << 'EOL'
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
EOL

# Create correct mapred-site.xml
cat > /usr/local/hadoop/etc/hadoop/mapred-site.xml << 'EOL'
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
EOL

# Create correct yarn-site.xml
cat > /usr/local/hadoop/etc/hadoop/yarn-site.xml << 'EOL'
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
EOL

# Show the content after the fix
echo "After fix, showing core-site.xml:"
grep -A 5 "<property>" /usr/local/hadoop/etc/hadoop/core-site.xml

# Format the NameNode
echo "Formatting NameNode..."
su - hadoop -c "cd /usr/local/hadoop && bin/hdfs namenode -format -force"

# Restart Hadoop services
echo "Restarting Hadoop services..."
su - hadoop -c "cd /usr/local/hadoop && sbin/stop-all.sh"
sleep 5
su - hadoop -c "cd /usr/local/hadoop && sbin/start-dfs.sh"
su - hadoop -c "cd /usr/local/hadoop && sbin/start-yarn.sh"

# Verify running services
echo "Checking running Hadoop services:"
su - hadoop -c "jps" 