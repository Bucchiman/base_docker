#!/usr/bin/zsh
#
# FileName:     entrypoint
# Author:       8ucchiman
# CreatedDate:  2023-07-27 13:10:49
# LastModified: 2023-12-24 22:29:38
# Reference:    8ucchiman.jp
# Description:  ---
#


# Reference: https://github.com/PINTO0309/PyTorch-build/blob/main/entrypoint.sh

#USER_ID=${LOCAL_UID:-9001}
#GROUP_ID=${LOCAL_GID:-9001}

# コンテナ内のユーザー指定
#echo "Starting with UID : $USER_ID, GID: $GROUP_ID"

#groupadd -g $LOCAL_UID $USER_NAME         # USER_IDにUSER_NAMEを追加

# echo $LOCAL_UID
# echo $LOCAL_GID
# echo $USER_NAME

#export DISPLAY=$DISPLAY:0
#echo $DISPLAY

groupadd -g $LOCAL_GID $USER_NAME
useradd --uid $LOCAL_UID --gid $LOCAL_GID -m $USER_NAME -d /home/$USER_NAME -s /usr/bin/zsh
gpasswd -a $USER_NAME sudo && gpasswd -a $USER_NAME dialout && gpasswd -a $USER_NAME video
export HOME=/home/$USER_NAME

sed -i -e 's/%sudo\tALL=(ALL:ALL) ALL/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

exec /usr/sbin/gosu $USER_NAME "$@"
