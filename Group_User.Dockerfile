# FileName: User_Group
# Author: 8ucchiman
# CreatedDate: 2023-01-27 18:10:10 +0900
# LastModified: 2023-01-27 18:10:22 +0900
# Reference: 8ucchiman.jp


FROM ubuntu:latest

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
USER $USERNAME
WORKDIR /home/$USERNAME/
