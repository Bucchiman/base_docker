FROM nvidia/cuda:10.2-base-ubuntu18.04

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
RUN mkdir ~/.config
RUN mkdir ~/git && cd ~/git && \
    git clone https://github.com/Bucchiman/dotfiles.git && \
    cd dotfiles && ./create_symbolic.sh

RUN wget https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh && \
    chmod u+x Anaconda3-5.1.0-Linux-x86_64.sh
#    bash Anaconda3-5.1.0-Linux-x86_64.sh


CMD ["/usr/bin/zsh"]

