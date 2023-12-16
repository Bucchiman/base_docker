#!/bin/bash

IMAGE_NAME=bucchiman_trial
CONTAINER_NAME=bucchiman_trycon
GPUS=all
SHM_SIZE=16gb

SCRIPT_PATH=`dirname ${0}`
DOCKERFILE_PATH="${SCRIPT_PATH}/Dockerfile"
PROJECT_ROOT=`cd ${SCRIPT_PATH} && cd .. && pwd`

case "$1" in
    build)
        docker build -t ${IMAGE_NAME} -f ${DOCKERFILE_PATH} ${PROJECT_ROOT}
        ;;
    run)
        if [ -n "$SUDO_USER" ]; then
            uid="$(id -u "$SUDO_USER")"
        else
            uid="$(id -u "$USER")"
        fi
        docker run --rm -it --gpus ${GPUS} --shm-size ${SHM_SIZE} \
            --name ${CONTAINER_NAME} \
            -e LOCAL_UID=$uid \
            -e LOCAL_GID=$uid \
            -v ${PROJECT_ROOT}:/share \
            ${IMAGE_NAME} /bin/bash
        ;;
    *)
        echo "Usage: $0 {build|run}"
        exit 1
        ;;
esac
