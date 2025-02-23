#!/bin/bash

# Ensure environment variables are set before running
if [ -z "$DOCKER_USERNAME" ] || [ -z "$DOCKER_PASS" ]; then
  echo "Error: DOCKER_USERNAME or DOCKER_PASS is not set!"
  exit 1
fi

# Secure Docker login
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Stop and remove existing container (if running)
docker stop react 2>/dev/null
docker rm react 2>/dev/null

# Build the Docker image
docker build -t react-ci/cd .

# Run a container from the created image
docker run -d -it --name react -p 80:80 react-ci/cd

# Push the image to DockerHub
docker tag react-ci/cd ravivarman46/react-app:ci-cd
docker push ravivarman46/react-app:ci-cd

