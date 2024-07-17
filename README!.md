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

1. Clones the repository: Retrieves the latest code from GitHub.
2. Sets up Kind cluster: Creates a local Kubernetes cluster using Kind.
3. Builds Docker images: Builds Docker images for frontend and backend services.
4. Applies Kubernetes configurations: Deploys the services to the Kind cluster.
5. Port forwards: Forward ports from the Kind cluster to the local machine to access the services.
Keep the terminal open to keep port forwarding active.


### 2. Run Playwright Tests
Once the setup.sh script is running and port forwarding is active, you can execute the Playwright tests.

```bash
# Run Playwright tests
npx playwright test

```
### Generate HTML Report

After running the Playwright tests, an HTML report can be generated to view detailed test results and summaries.

### 3. Teardown
After the Playwright tests are complete, run the cleanup.sh script to clean up the environment.
```bash
# Make sure the script is executable
chmod +x scripts/cleanup.sh

# Run the cleanup script
./scripts/cleanup.sh

```
