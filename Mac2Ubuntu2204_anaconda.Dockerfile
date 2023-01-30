# FileName: Mac2Ubuntu2204_anaconda
# Author: 8ucchiman
# CreatedDate: 2023-01-28 06:21:41 +0900
# LastModified: 2023-01-29 00:33:52 +0900
# Reference: 8ucchiman.jp


FROM ubuntu:latest

RUN apt-get update && apt-get install -y neofetch git zsh sudo wget
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install neovim -y



ARG username=bucchiman
ARG wkdir=/home/bucchiman


RUN echo "root:root" | chpasswd && \
    adduser --disabled-password --gecos "" "${username}" && \
    echo "${username}:${username}" | chpasswd && \
    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${username} && \
    chmod 0440 /etc/sudoers.d/${username}

USER ${username}
WORKDIR /home/${username}
#RUN mkdir ~/git && cd ~/git && \
#    git clone https://github.com/Bucchiman/dotfiles.git && \
#    cd dotfiles && ./create_symbolic.sh

#RUN wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh


CMD ["/usr/bin/zsh"]

