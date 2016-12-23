#!/bin/bash

docker login -u="$QUAY_USERNAME" -p="$QUAY_PASSWORD" quay.io
docker tag keboola/docker-base-r quay.io/keboola/docker-base-r:$TRAVIS_TAG
docker tag keboola/docker-base-r quay.io/keboola/docker-base-r:latest
docker images
docker push quay.io/keboola/docker-base-r:$TRAVIS_TAG
docker push quay.io/keboola/docker-base-r:latest
