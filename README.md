# Frontend and Backend Integration Testing

This repository provides a script for automating integration tests for frontend and backend services using Playwright. Follow the instructions below to set up the environment, deploy the services, and run the tests.

## Prerequisites

Before you start, make sure you have the following installed on your local machine:

- **[Node.js](https://nodejs.org/)** (>=14.x)
- **[kubectl](https://kubernetes.io/docs/tasks/tools/)** (Kubernetes CLI)
- **[Docker](https://www.docker.com/get-started)** (for building images)
- **[Kind](https://kind.sigs.k8s.io/docs/user/quick-start/)** (Kubernetes IN Docker)

## Setup

### 1. Clone the Repository


First, clone this repository to your local machine:

```bash
git clone https://github.com/Vengatesh-m/qa-test
cd qa-test
```

### 2. Set Up Kind Cluster

```bash
kind create cluster
```

### 3. Build and Push Docker Images

```bash
# Build the Docker images
docker build -t backend:v1 -f backend/Dockerfile .
docker build -t frontend:v1 -f frontend/Dockerfile .

# Load images into the Kind cluster
kind load docker-image backend:v1
kind load docker-image frontend:v1
```
### 4. Apply the Kubernetes Configurations

```bash
kubectl apply -f Deployment/backend-deployment.yaml
kubectl apply -f Deployment/frontend-deployment.yaml
```

### 5. Verify Deployment
```bash
kubectl get services
kubectl get deployments
kubectl get pods
```

### 6. Port Forward for Frontend Service and Backend Service
```bash
# Port forward for the backend service
kubectl port-forward service/backend-service 9090:3000

# Open another terminal and set up port forward for the frontend service
kubectl port-forward service/frontend-service 8080:80
```

### 7. Run the Automated Test Script
```bash
# Install Playwright and its dependencies
npm install @playwright/test

# Install Playwright browsers
npx playwright install

# Run the Playwright test script
npx playwright test frontend-backend-integration.test.js
```

