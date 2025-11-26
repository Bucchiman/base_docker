#!/bin/zsh
#
# FileName:     make_container4nas
# Author:       8ucchiman
# CreatedDate:  2025-11-26 21:02:40
# LastModified: 2025-11-26 21:13:32
# Reference:    8ucchiman.jp
# Description:  ---
#


# set -ex        # 途中のエラーで実行中断


#@
function update_submodules () {
    $(cd $BASE_DIR; git submodule update --init --recursive)   # cloneした後submoduleをclone 
}

#@
function submodule_add () {
    typeset -A platforms
    platforms=(
        github git@github.com:Bucchiman/
        gitlab git@gitlab.com:Bucchiman/
    )
    local target_platform=`array_fzf "${(k)platforms[*]}"`
    echo -n "project name> ${platforms[$target_platform]}"
    read project_name
    local repository_url=${platforms[$target_platform]}${project_name}.git
    mkdir -p ${BASE_DIR}/submodules; cd $_; git submodule add $repository_url ${project_name}
}

#@
function fzf_install () {
}

#@
function set_variables () {
    #
    #
    #
    #
    echo "******************************"
    echo "* set_variables              *"
    echo "******************************"
    BASE_DIR=$PWD
    BMODS_PATH=$HOME/Bmods
    ### you can write
    typeset -A -g SUBMODULES=(
        repo_name https://github.com/ # blablabla ...
    )
    typeset -A -g Reference_lst=(
        ref_name https:// # blablabla ...
    )
    echo "BASE_DIR=$PWD"
}
#@
function create_devbox () {
    devbox init;
    devbox shell;
}

#@
function open () {
    #lopen
}

#@ archive
function setup () {
    if [[ -e $BASE_DIR/local ]]; then
        source local
    fi
}

#@ archive
function build () {
    #lbuild
}

#@ archive
function run () {
    #lrun
    docker run -it --rm -e DISPLAY=$DISPLAY \
               -v /tmp/.X11-unix:/tmp/.X11-unix \
               -v $HOME/.Xauthority:/root/.Xauthority:ro \
               --network host basic
}

#@ archive
function clean () {
    #lclean
}


#@ archive
function default () {
    #
    # this is default setting
    # you can run this function without no arguments.
    #
    echo "******************************"
    echo "* default                    *"
    echo "******************************"
    echo "this is default setting"
    echo "you can run this function without no arguments."
    #build
    run
}


#######################################
#@ archive
function main01 () {
    set_variables
    setup
    source $BMODS_PATH
    if [[ $@ == "" ]]; then
        default
    elif [[ $@ == "." ]]; then
        local target_func=`choose_local_function $BASE_DIR/Brun`
        eval $target_func
    else
        eval $@
    fi

}

ME=$0
main01 $@
#######################################


return

