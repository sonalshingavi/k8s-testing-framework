#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print messages
print_message() {
    echo ""
    echo "=============================="
    echo "$1"
    echo "=============================="
    echo ""
}

# Function to clean up Docker containers and images
cleanup_docker() {
    print_message "Cleaning up Docker containers and images"

    # Remove containers starting with 'frontend' and 'backend'
    docker ps -a -q --filter "name=^frontend" | xargs --no-run-if-empty docker rm -f
    docker ps -a -q --filter "name=^backend" | xargs --no-run-if-empty docker rm -f

    # Remove images starting with 'frontend' and 'backend'
    docker images -q --filter "reference=frontend*" | xargs --no-run-if-empty docker rmi -f
    docker images -q --filter "reference=backend*" | xargs --no-run-if-empty docker rmi -f
}

# Function to clean up Kind clusters
cleanup_kind() {
    print_message "Cleaning up Kind cluster"
    
    # Check if the Kind cluster exists and delete it
    if kind get clusters | grep -q 'kind'; then
        kind delete cluster
    fi
}

# Function to remove the 'qa-test' directory
cleanup_directory() {
    print_message "Removing 'qa-test' directory"

    if [ -d "qa-test" ]; then
        rm -rf qa-test
    else
        print_message "'qa-test' directory does not exist"
    fi
}

# Clean up Docker containers and images
cleanup_docker

# Clean up Kind cluster
cleanup_kind

# Remove the 'qa-test' directory
cleanup_directory

print_message "Cleanup complete. All Docker images and containers have been removed, the Kind cluster has been deleted, and the 'qa-test' directory has been removed."
