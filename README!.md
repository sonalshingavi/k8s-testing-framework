# QA Test Automation

This repository contains the setup, execution, and teardown scripts for automating end-to-end tests using Playwright in a Kubernetes environment. This README provides instructions for setting up the environment, running the tests, and cleaning up resources.

## Prerequisites

Before you begin, ensure that you have the following tools installed in local machine:

- [Docker](https://docs.docker.com/get-docker/)
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installing-kind)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Node.js](https://nodejs.org/) (with `npm` or `yarn`)
- [Playwright](https://playwright.dev/docs/intro) (installable via `npm`)

## Setup

To prepare the environment for running Playwright tests, follow these steps:

### 1. Run `setup.sh`

The `setup.sh` script sets up the Kind cluster, builds Docker images, deploys the services, and forwards ports for frontend and backend services.

```bash
# Make sure the script is executable
chmod +x setup.sh

# Run the setup script
./setup.sh
```

This script performs the following actions:

Clones the repository: Retrieves the latest code from GitHub.
Sets up Kind cluster: Creates a local Kubernetes cluster using Kind.
Builds Docker images: Builds Docker images for frontend and backend services.
Applies Kubernetes configurations: Deploys the services to the Kind cluster.
Port forwards: Forwards ports from the Kind cluster to the local machine for accessing the services.
Keep the terminal open to keep port forwarding active.


### Run Playwright Tests
Once the setup.sh script is running and port forwarding is active, you can execute the Playwright tests.

```bash
# Run Playwright tests
npx playwright test

```
### 3. 3. Teardown
After the Playwright tests are complete, run the cleanup.sh script to clean up the environment.
```bash
# Make sure the script is executable
chmod +x cleanup.sh

# Run the cleanup script
./cleanup.sh
```
