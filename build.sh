#!/bin/sh

ALPINE_VERSIONS="3.3 3.4 3.5 3.6"
IMAGE_VERSION="1"

DOCKER_USER="winlu"
DOCKER_IMAGE="docker-git-server"


build_image() {
    IMAGE_VER=$1
    ALPINE_VER=$2
    docker build --build-arg ALPINE_VER=$ALPINE_VER . -t $DOCKER_USER/$DOCKER_IMAGE:$IMAGE_VER-$ALPINE_VER
}

for t in `eval echo $ALPINE_VERSIONS`;
do
    TAG=$DOCKER_USER/$DOCKER_IMAGE:$IMAGE_VERSION-$t
    echo Building $TAG
    build_image $IMAGE_VERSION $t
done

docker build --build-arg ALPINE_VER=3.6 . -t $DOCKER_USER/$DOCKER_IMAGE:latest
