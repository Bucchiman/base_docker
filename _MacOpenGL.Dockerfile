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



# Update the package repository and install necessary packages
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        mesa-utils \
        libgl1-mesa-glx \
        libglfw3-dev

COPY entrypoint.sh /root/docker/

RUN chmod +x /root/docker/entrypoint.sh
ENTRYPOINT ["/root/docker/entrypoint.sh"]
