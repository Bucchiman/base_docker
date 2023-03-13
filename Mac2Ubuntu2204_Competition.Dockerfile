# FileName: Mac2Ubuntu2204_Competition
# Author: 8ucchiman
# CreatedDate: 2023-02-11 12:58:46 +0900
# LastModified: 2023-02-11 13:43:55 +0900
# Reference: 8ucchiman.jp


FROM --platform=linux/amd64 ubuntu:latest

RUN apt-get update && apt-get install -y neofetch git zsh sudo wget
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install neovim -y
RUN apt-get install fzf bat -y
RUN mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat



ARG username=bucchiman
ARG wkdir=/home/bucchiman


RUN echo "root:root" | chpasswd && \
    adduser --disabled-password --gecos "" "${username}" && \
    echo "${username}:${username}" | chpasswd && \
    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${username} && \
    chmod 0440 /etc/sudoers.d/${username}

USER ${username}
WORKDIR /home/${username}
RUN mkdir ~/.config
RUN mkdir ~/git && cd ~/git && \
    git clone https://github.com/Bucchiman/dotfiles.git && \
    cd dotfiles && ./create_symbolic.sh

RUN wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh

RUN cd ~; mkdir datas compe
# VOLUME

CMD ["/usr/bin/zsh"]

