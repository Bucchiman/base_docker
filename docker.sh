#!/bin/zsh
#
# FileName:     docker
# Author:       8ucchiman
# CreatedDate:  2023-12-16 12:55:13
# LastModified: 2023-12-16 14:34:27
# Reference:    8ucchiman.jp
# Description:  ---
#


function set_variables () {
    local IMAGE_OPTS=
    if [[  ]]
    local CONTAINER_OPTS=
}

function build () {
    #
    # @Description  build docker image
    # @params       
    # @Example      ./docker.sh build
    # @Reference    
    #

    docker build $IMAGE_OPTS $@ 
}

function run () {
    #
    # @Description  run docker container
    # @params       
    # @Example      ./docker.sh run
    # @Reference    https://qiita.com/egawa_kun/items/714394609eef6be8e0bf
    #

    docker run $CONTAINER_OPTS $@
}

set_variables
eval $@
