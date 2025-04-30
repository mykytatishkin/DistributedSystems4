#!/bin/bash
# This script copies the MapReduce examples script to the running Hadoop container

# Make the run-mapreduce-examples.sh file executable
chmod +x run-mapreduce-examples.sh

# Copy the script to the container
echo "Copying MapReduce examples script to the container..."
docker cp run-mapreduce-examples.sh hadoop-node:/run-mapreduce-examples.sh

# Make the script executable inside the container
echo "Making the script executable inside the container..."
docker exec hadoop-node chmod +x /run-mapreduce-examples.sh

echo "Script copied successfully! You can now run it with:"
echo "docker exec -it hadoop-node bash"
echo "bash /run-mapreduce-examples.sh" 