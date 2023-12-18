#
# FileName:     core
# Author:       8ucchiman
# CreatedDate:  2023-12-15 22:41:33
# LastModified: 2023-12-16 12:29:16
# Reference:    8ucchiman.jp
# Description:  ---
#


FROM ubuntu:22.04
ENV TZ=Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update -y && \
    apt-get install -y tzdata
#RUN DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    neofetch \
    git \
    zsh \
    sudo \
    software-properties-common \
    x11-apps \
    cmake \
    g++ \
    wget \
    unzip \
    libgtk2.0-dev \
    pkg-config

#RUN add-apt-repository ppa:neovim-ppa/unstable
#RUN apt-get install -y neovim


# TimeZone を設定
RUN echo $TZ > /etc/timezone \
  && rm /etc/localtime \
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata


#RUN apt-get update && add-apt-repository --yes ppa:xqms/opencv-nonfree && apt-get update && apt-get install libopencv-nonfree-dev
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install -y neovim
RUN apt-get install fzf bat -y
RUN mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat



#RUN echo "root:root" | chpasswd && \
#    adduser --disabled-password --gecos "" "${username}" && \
#    echo "${username}:${username}" | chpasswd && \
#    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${username} && \
#    chmod 0440 /etc/sudoers.d/${username}


ARG USER_NAME
# id -u
ARG USER_ID
# id -g
ARG GROUP_ID


RUN groupadd -g ${USER_ID} ${USER_NAME}         # USER_IDにUSER_NAMEを追加
RUN useradd --uid ${USER_ID} --gid ${USER_NAME} -m ${USER_NAME} -d /home/${USER_NAME} -s /usr/bin/zsh #
RUN gpasswd -a ${USER_NAME} sudo && gpasswd -a ${USER_NAME} dialout && gpasswd -a ${USER_NAME} video

RUN sed -i -e 's/%sudo\tALL=(ALL:ALL) ALL/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

ENV DISPLAY :0
