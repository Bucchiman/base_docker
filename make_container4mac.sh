#!/bin/zsh
#
# FileName:     make_container4mac
# Author:       8ucchiman
# CreatedDate:  2023-04-23 10:25:34
# LastModified: 2023-01-23 14:11:45 +0900
# Reference:    8ucchiman.jp
#


function _usage() {
    echo "Usage: $0 -i image_name -g gpu_flag -c container_name"
    exit 1
}


while getopts :i:c:g OPT
do
    case $OPT in
        i) image_name=$OPTARG;;
        g) gpu_flag=true;;
        c) container_name=$OPTARG;;
        :|\?) _usage;;
    esac
done

nohup socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" & # socatで6000番占有


docker run -ti --rm \
           -e DISPLAY=docker.for.mac.host.internal:0 \
           -v $HOME/.ssh:/home/bucchiman/.ssh \
	   -v $HOME/common:/home/bucchiman/common \
           bucchiman/mac_opencv

return

