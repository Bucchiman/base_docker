#!/bin/zsh
#
# FileName: 	make_container
# Author: 8ucchiman
# CreatedDate:  2023-01-26 17:02:35 +0900
# LastModified: 2023-03-23 16:24:26 +0900
# Reference: 8ucchiman.jp
#




function _usage() {
    echo "Usage: $0 -i image_name -g gpu_flag"
    exit 1
}

if [[ $# = 0 ]]
then
    echo No arguments or options
    exit 1
fi

while getopts :i:g OPT
do
    case $OPT in
        i) image_name=$OPTARG;;
        g) gpu_flag=true;;
        :|\?) _usage;;
    esac
done
if [[ -z gpu_flag ]]
then
    docker run -it --rm --gpus all \
               --net host \
               --env DISPLAY=$DISPLAY \
               --volume $HOME/.Xauthority:/home/bucchiman/.Xauthority \
               --volume $HOME/.config/snippets:/home/bucchiman/lib \
               --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
               --user="bucchiman" \
               $image_name
else
    docker run -it --rm \
               --net host \
               --env DISPLAY=$DISPLAY \
               --volume $HOME/.Xauthority:/home/bucchiman/.Xauthority \
               --volume $HOME/.config/snippets:/home/bucchiman/lib \
               --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
               --user="bucchiman" \
               $image_name
fi
return
