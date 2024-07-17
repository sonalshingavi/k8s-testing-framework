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

# Function to wait for pods to be in the Running state
wait_for_pods() {
    print_message "Waiting for pods to be in the Running state"

    local deployment_name=$1

    while true; do
        pod_status=$(kubectl get pods -l app=$deployment_name -o jsonpath="{.items[0].status.phase}")
        if [[ $pod_status == "Running" ]]; then
            break
        else
            echo "Waiting for pod of deployment '$deployment_name' to be in Running state. Current status: $pod_status"
            sleep 5
        fi
    done
    print_message "Pod for deployment '$deployment_name' is now in the Running state"
}

# 1. Clone the Repository
print_message "Cloning the repository"
git clone https://github.com/Vengatesh-m/qa-test
cd qa-test

# 2. Set Up Kind Cluster
print_message "Setting up Kind cluster"
kind create cluster

# 3. Build and Push Docker Images
print_message "Building Docker images"
docker build -t backend:v1 -f backend/Dockerfile .
docker build -t frontend:v1 -f frontend/Dockerfile .

print_message "Loading Docker images into Kind cluster"
kind load docker-image backend:v1
kind load docker-image frontend:v1

# 4. Apply the Kubernetes Configurations
print_message "Applying Kubernetes configurations"
kubectl apply -f Deployment/backend-deployment.yaml
kubectl apply -f Deployment/frontend-deployment.yaml

# 5. Verify Deployment
print_message "Verifying deployment"
kubectl get services
kubectl get deployments
kubectl get pods

# 6. Wait for the backend and frontend pods to be in the Running state
wait_for_pods "backend"
wait_for_pods "frontend"

# 7. Port Forward for Frontend Service and Backend Service
print_message "Setting up port forwarding for backend service"
kubectl port-forward service/backend-service 9090:3000 &
BACKEND_PID=$!

print_message "Setting up port forwarding for frontend service"
kubectl port-forward service/frontend-service 8080:80 &
FRONTEND_PID=$!

# Print port forwarding details
print_message "Port forwarding is set up. You can access the services at:"
print_message "Backend service: http://localhost:9090"
print_message "Frontend service: http://localhost:8080"
print_message "Playwright tests can now be executed. Run 'playwright test' in a separate terminal to start the tests."

# Keep the script running to allow background port forwarding
print_message "Setup complete. Keeping port forwarding alive. You can run 'playwright test' in another terminal to execute the tests."
# Wait forever to keep port forwarding alive
wait
