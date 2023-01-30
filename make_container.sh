#!/bin/zsh
#
# FileName: 	make_container
# Author: 8ucchiman
# CreatedDate:  2023-01-26 17:02:35 +0900
# LastModified: 2023-01-29 00:37:15 +0900
# Reference: 8ucchiman.jp
#




function _usage() {
    echo "Usage: $0 -i image_name"
    exit 1
}

if [[ $# = 0 ]]
then
    echo No arguments or options
    exit 1
fi

while getopts :i: OPT
do
    case $OPT in
        i) image_name=$OPTARG;;
        :|\?) _usage;;
    esac
done
docker run -it --gpus all $image_name
return
