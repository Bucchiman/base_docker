FROM ubuntu:18.04

RUN apt-get update && apt-get install -y neofetch git zsh sudo
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install neovim



ARG username=bucchiman
ARG wkdir=/home/bucchiman


RUN echo "root:root" | chpasswd && \
    adduser --disabled-password --gecos "" "${username}" && \
    echo "${username}:${username}" | chpasswd && \
    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${username} && \
    chmod 0440 /etc/sudoers.d/${username}

USER ${username}
WORKDIR /home/${username}
RUN mkdir ~/git && cd ~/git && \
    git clone https://github.com/Bucchiman/dotfiles.git && \
    cp dotfiles/.zshrc ~ && cp -r dotfiles/.config ~


CMD ["/usr/bin/zsh"]


