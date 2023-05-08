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

docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Cinemashkachikachika.17" \
           -p 1433:1433 --name 8sql --hostname 8sql \
           -d \
           --volume $HOME/common:/common \
           mcr.microsoft.com/mssql/server:2022-latest

return
