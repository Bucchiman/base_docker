FROM nvidia/cuda:12.0.0-devel-ubuntu22.04

RUN apt-get update && apt-get install -y neofetch git zsh sudo
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
RUN mkdir ~/git && cd ~/git && \
    git clone https://github.com/Bucchiman/dotfiles.git && \
    cd dotfiles && ./create_symbolic.sh

RUN sudo apt-get install -y python3-pip libgl1-mesa-dev
RUN pip3 install -U pip
RUN pip3 install jupyterlab kaggle pandas numpy scikit-learn opencv-python matplotlib imblearn
RUN pip3 install torch torchvision torchaudio
RUN pip3 install pytorch_tabular


CMD ["/usr/bin/zsh"]

