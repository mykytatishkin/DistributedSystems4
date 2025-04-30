FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic packages
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
EXPOSE 9870 8088 9864 9000 22

# Set the entrypoint
CMD ["/bin/bash", "/install-hadoop.sh"] 