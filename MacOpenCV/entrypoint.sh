#!/bin/zsh

USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

# コンテナ内のユーザー指定
echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
useradd -u $USER_ID -o -m dockeruser
groupmod -g $GROUP_ID dockeruser
gpasswd -a dockeruser sudo && gpasswd -a dockeruser dialout && gpasswd -a dockeruser video
export HOME=/home/dockeruser

sed -i -e 's/%sudo\tALL=(ALL:ALL) ALL/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

# torchvision をソースからビルド
cd /workspace/torchvision
FORCE_CUDA=1 python setup.py develop

exec /usr/sbin/gosu dockeruser "$@"
