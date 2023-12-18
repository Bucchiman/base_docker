#!/bin/zsh
#
# FileName:     docker
# Author:       8ucchiman
# CreatedDate:  2023-12-16 12:33:25
# LastModified: 2023-12-16 12:35:49
# Reference:    8ucchiman.jp
# Description:  ---
#


function set_variables () {
    IMAGE_NAME=humble
    CONTAINER_NAME=humble
    #GPUS=all
    SHM_SIZE=16gb

    SCRIPT_PATH=`dirname ${0}`
    DOCKERFILE_PATH="${SCRIPT_PATH}/Ros2_humble.Dockerfile"
    PROJECT_ROOT=`cd ${SCRIPT_PATH} && cd .. && pwd`
}

function build () {
    docker build -t ${IMAGE_NAME} -f ${DOCKERFILE_PATH} ${PROJECT_ROOT}
}

function run () {
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
}
set_variables
eval $@
