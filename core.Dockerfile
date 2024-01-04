#
# FileName:     core
# Author:       8ucchiman
# CreatedDate:  2023-12-25 01:25:22
# LastModified: 2023-12-25 01:32:35
# Reference:    8ucchiman.jp
# Description:  ---
#


FROM ubuntu:latest

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y gosu tzdata fonts-noto-cjk

RUN apt-get update && apt-get install -y \
    neofetch \
    git \
    zsh \
    sudo \
    x11-apps \
    vim \
    g++ \
    curl \
    unzip

RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install neovim -y
RUN apt-get install fzf bat -y
RUN mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat

RUN apt-get install -y cmake pkg-config
RUN apt-get install -y mesa-utils libglu1-mesa-dev freeglut3-dev mesa-common-dev
RUN apt-get install -y libglew-dev libglfw3-dev libglm-dev
RUN apt-get install -y libao-dev libmpg123-dev libxi-dev
RUN apt-get install -y libxinerama-dev libxcursor-dev

