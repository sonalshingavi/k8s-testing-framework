# QA Test Automation

# Frontend and Backend Integration Testing

This repository provides a script for automating integration tests for frontend and backend services using Playwright. This README provides instructions for setting up the environment, running the tests, and cleaning up resources.

## Prerequisites

Before you begin, ensure that you have the following tools installed on the local machine:

- [Docker](https://docs.docker.com/get-docker/)
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installing-kind)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Node.js](https://nodejs.org/) 
- [Playwright](https://playwright.dev/docs/intro) (installable via `npm`)

## Setup

To prepare the environment for running Playwright tests, follow these steps:

### 1. Run `setup.sh`

The `setup.sh` script sets up the Kind cluster, builds Docker images, deploys the services, and forwards ports for frontend and backend services.

```bash
# Make sure the script is executable
chmod +x scripts/setup.sh

# Run the setup script
./scripts/setup.sh

```

This script performs the following actions:
##### 1. Clone the Repository
First, clone this repository to your local machine:

```bash
git clone https://github.com/Vengatesh-m/qa-test
cd qa-test
```

##### 2. Set Up Kind Cluster

```bash
kind create cluster
```

##### 3. Build and Push Docker Images

```bash
# Build the Docker images
docker build -t backend:v1 -f backend/Dockerfile .
docker build -t frontend:v1 -f frontend/Dockerfile .

# Load images into the Kind cluster
kind load docker-image backend:v1
kind load docker-image frontend:v1
```
##### 4. Apply the Kubernetes Configurations

```bash
kubectl apply -f Deployment/backend-deployment.yaml
kubectl apply -f Deployment/frontend-deployment.yaml
```

##### 5. Port Forward for Frontend Service and Backend Service
 keep the terminal open to keep port forwarding active.
```bash
# Port forward for the backend service
kubectl port-forward service/backend-service 9090:3000

# Open another terminal and set up a port forward for the frontend service
kubectl port-forward service/frontend-service 8080:80
```

### 2. Run Playwright Tests
Once the setup.sh script is running and port forwarding is active, you can execute the Playwright tests.

```bash
# Run Playwright tests
npx playwright test

```
#### Generate HTML Report

After running the Playwright tests, an HTML report can be generated to view detailed test results and summaries.

### 3. Teardown
After the Playwright tests are complete, run the cleanup.sh script to clean up the environment.
```bash
# Make sure the script is executable
chmod +x scripts/cleanup.sh

# Run the cleanup script
./scripts/cleanup.sh

```
