FROM ubuntu:20.04

# Set environment variables
# DEBIAN_FRONTEND=noninteractive prevents interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic packages
# - openjdk-8-jdk: Java Development Kit required by Hadoop
# - wget: Used for downloading files
# - ssh: Required for Hadoop services communication
# - pdsh: Parallel distributed shell for cluster management
# - nano: Simple text editor for configuration files
# I clean up the apt cache to reduce image size
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-8-jdk \
    wget \
    ssh \
    pdsh \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Copy the installation script
COPY install-hadoop.sh /install-hadoop.sh

# Make the script executable
RUN chmod +x /install-hadoop.sh

# Expose Hadoop ports
# - 9870: NameNode web UI
# - 8088: ResourceManager web UI
# - 9864: DataNode web UI
# - 9000: HDFS default FS port
# - 22: SSH port for inter-service communication
EXPOSE 9870 8088 9864 9000 22

# Set the entrypoint
CMD ["/bin/bash", "/install-hadoop.sh"] 