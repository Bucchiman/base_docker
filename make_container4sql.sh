#!/bin/zsh
#
# FileName:     make_container4sql
# Author:       8ucchiman
# CreatedDate:  2023-05-08 13:32:21
# LastModified: 2023-01-23 14:11:45 +0900
# Reference:    https://learn.microsoft.com/ja-jp/sql/linux/quickstart-install-connect-docker?view=sql-server-ver16&pivots=cs1-bash
# Description:  ---
#


#function _usage() {
#}
#
#
#while getopts :i:c:g OPT
#do
#    case $OPT in
#        i) image_name=$OPTARG;;
#        g) gpu_flag=true;;
#        c) container_name=$OPTARG;;
#        :|\?) _usage;;
#    esac
#done

docker run --name bucchiman_mysql -e MYSQL_ROOT_PASSWORD=gehogeho -d bucchiman/mysql:latest
#docker exec -it bucchiman_mysql zsh

return
