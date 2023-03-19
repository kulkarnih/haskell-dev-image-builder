#!/bin/bash

# Uses rendered Dockerfile to build and push image

if [ -z $1 ]; then
    echo "First argument missing: LTS number."
    exit 1
fi

if [ -z $2 ]; then
    echo "Second argument missing: Image name."
    exit 1
fi

SNAPSHOT=$1
IMAGE_NAME="$2"
SNAPSHOT_IMAGE_NAME="$IMAGE_NAME:$SNAPSHOT"
LATEST_IMAGE_NAME="$IMAGE_NAME:latest"
DOCKERFILE="$SNAPSHOT/Dockerfile"

printf "Building $SNAPSHOT_IMAGE_NAME from $DOCKERFILE\n"

docker build -f "$DOCKERFILE" -t "$SNAPSHOT_IMAGE_NAME" -t "$LATEST_IMAGE_NAME" .

if [ $? -eq 0 ]; then
    docker push "$SNAPSHOT_IMAGE_NAME"
    docker push "$LATEST_IMAGE_NAME"
else
    printf "Docker image build failed.\n"
fi

if [ $? -eq 0 ]; then
    printf "Pushed $SNAPSHOT_IMAGE_NAME and $LATEST_IMAGE_NAME."
else
    printf "Docker image push failed.\n"
fi
