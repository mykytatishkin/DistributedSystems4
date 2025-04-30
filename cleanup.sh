#!/bin/bash
# Cleanup script for Hadoop Docker setup
# This script helps clean up resources used during the Hadoop Docker assignment

# Text formatting
BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print messages
print_message() {
    echo -e "${BOLD}${2}${1}${NC}"
}

# Function to stop the Hadoop container
stop_container() {
    print_message "Stopping Hadoop container..." "${YELLOW}"
    
    # Check if container exists and is running
    if docker ps -q --filter "name=hadoop-node" | grep -q .; then
        docker stop hadoop-node
        print_message "Container stopped successfully." "${GREEN}"
    else
        print_message "Container 'hadoop-node' is not running." "${YELLOW}"
    fi
}

# Function to remove the Hadoop container
remove_container() {
    print_message "Removing Hadoop container..." "${YELLOW}"
    
    # Check if container exists
    if docker ps -a -q --filter "name=hadoop-node" | grep -q .; then
        docker rm hadoop-node
        print_message "Container removed successfully." "${GREEN}"
    else
        print_message "Container 'hadoop-node' does not exist." "${YELLOW}"
    fi
}

# Function to remove the Hadoop Docker image
remove_image() {
    print_message "Removing Hadoop Docker image..." "${YELLOW}"
    
    # Check if image exists
    if docker images -q hadoop-setup | grep -q .; then
        docker rmi hadoop-setup
        print_message "Image removed successfully." "${GREEN}"
    else
        print_message "Image 'hadoop-setup' does not exist." "${YELLOW}"
    fi
}

# Function to remove temporary files
remove_temp_files() {
    print_message "Removing temporary files..." "${YELLOW}"
    
    # Clean up any temporary files that might have been created
    find . -name "*.log" -type f -delete
    find . -name "*.tmp" -type f -delete
    find . -name "*.temp" -type f -delete
    
    # Ask about screenshots
    read -p "$(echo -e ${BOLD}"Do you want to remove screenshot files? This is NOT recommended before submission. [y/N]: "${NC})" remove_screenshots
    
    if [[ $remove_screenshots =~ ^[Yy]$ ]]; then
        find . -name "screenshot_*.png" -type f -delete
        find . -name "*.jpg" -type f -delete
        print_message "Screenshots removed." "${YELLOW}"
    fi
    
    print_message "Temporary files cleaned up." "${GREEN}"
}

# Function to perform full cleanup
full_cleanup() {
    print_message "Performing full cleanup..." "${YELLOW}"
    stop_container
    remove_container
    remove_image
    remove_temp_files
    print_message "Full cleanup completed." "${GREEN}"
}

# Main menu
show_menu() {
    echo
    print_message "HADOOP DOCKER SETUP - CLEANUP UTILITY" "${GREEN}"
    echo
    echo -e "${BOLD}Select an option:${NC}"
    echo "1) Stop Hadoop container"
    echo "2) Remove Hadoop container"
    echo "3) Remove Hadoop Docker image"
    echo "4) Remove temporary files"
    echo "5) Full cleanup (all of the above)"
    echo "0) Exit"
    echo
    read -p "$(echo -e ${BOLD}"Enter your choice [0-5]: "${NC})" choice
    
    case $choice in
        1) stop_container ;;
        2) remove_container ;;
        3) remove_image ;;
        4) remove_temp_files ;;
        5) full_cleanup ;;
        0) print_message "Exiting cleanup utility." "${GREEN}"; exit 0 ;;
        *) print_message "Invalid option. Please try again." "${RED}" ;;
    esac
    
    # Return to menu
    echo
    read -p "$(echo -e ${BOLD}"Press Enter to continue..."${NC})"
    show_menu
}

# Start the menu
show_menu 