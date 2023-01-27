FROM nvidia/cuda:12.0.0-devel-ubuntu22.04

RUN apt-get update && apt-get install -y neofetch git zsh sudo
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install neovim -y
RUN apt-get install curl -y
RUN apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 -y

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

RUN curl -O https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
CMD ["/usr/bin/zsh"]

