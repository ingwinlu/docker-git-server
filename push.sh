#!/bin/sh

ALPINE_VERSIONS="3.3 3.4 3.5 3.6"
IMAGE_VERSION="`git describe --abbrev=0 --tags`"

DOCKER_USER="winlu"
DOCKER_IMAGE="docker-git-server"


push_image() {
    IMAGE_VER=$1
    ALPINE_VER=$2
    docker push $DOCKER_USER/$DOCKER_IMAGE:$IMAGE_VER-$ALPINE_VER
}

for t in `eval echo $ALPINE_VERSIONS`;
do
    TAG=$DOCKER_USER/$DOCKER_IMAGE:$IMAGE_VERSION-$t
    echo Pushing $TAG
    push_image $IMAGE_VERSION $t
done

docker push $DOCKER_USER/$DOCKER_IMAGE:latest
