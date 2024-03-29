# FileName: Mac2Ubuntu2204_Competition
# Author: 8ucchiman
# CreatedDate: 2023-02-11 12:58:46 +0900
# LastModified: 2023-03-23 16:08:15 +0900
# Reference: 8ucchiman.jp


FROM --platform=linux/amd64 ubuntu:latest

RUN apt-get update && apt-get install -y neofetch git zsh sudo wget eog
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install neovim -y
RUN apt-get install fzf bat -y
RUN mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat


ARG USER_NAME
# id -u
ARG USER_ID
# id -g
ARG GROUP_ID


RUN groupadd -g ${USER_ID} ${USER_NAME}         # USER_IDにUSER_NAMEを追加
RUN useradd --uid ${USER_ID} --gid ${USER_NAME} -m ${USER_NAME} -d /home/${USER_NAME} -s /usr/bin/zsh #
RUN gpasswd -a ${USER_NAME} sudo && gpasswd -a ${USER_NAME} dialout && gpasswd -a ${USER_NAME} video

RUN sed -i -e 's/%sudo\tALL=(ALL:ALL) ALL/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers


USER ${USER_NAME}
WORKDIR /home/${USER_NAME}
RUN mkdir ~/.config
RUN mkdir ~/git && cd ~/git && \
    git clone https://github.com/Bucchiman/dotfiles.git && \
    cd dotfiles && ./create_symbolic.sh

RUN wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh

RUN cd ~; mkdir datas compe
# VOLUME

CMD ["/usr/bin/zsh"]

