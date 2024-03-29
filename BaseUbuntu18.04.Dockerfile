# FileName:     BaseUbuntu18.04.Dockerfile
# Author:       8ucchiman
# CreatedDate:  2023-01-28 06:21:41 +0900
# LastModified: 2023-03-23 16:10:18 +0900
# Reference:    8ucchiman.jp


FROM ubuntu:18.04

RUN apt-get update && apt-get install -y neofetch git zsh sudo x11-apps vim eog wget
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install neovim -y
RUN apt-get install fzf bat -y
RUN mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat


ENV SHELL=/usr/bin/zsh
ARG USER_NAME
ARG USER_ID
ARG GROUP_ID


RUN groupadd -g ${USER_ID} ${USER_NAME}         # USER_IDにUSER_NAMEを追加
RUN useradd --uid ${USER_ID} --gid ${GROUP_ID} -m ${USER_NAME} -d /home/${USER_NAME} -s /usr/bin/zsh #
RUN gpasswd -a ${USER_NAME} sudo && gpasswd -a ${USER_NAME} dialout && gpasswd -a ${USER_NAME} video
RUN sed -i -e 's/%sudo\tALL=(ALL:ALL) ALL/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

#USER ${USER_NAME}
#WORKDIR /home/${USER_NAME}}
#RUN mkdir ~/git && cd ~/git && \
#    git clone https://github.com/Bucchiman/dotfiles.git && \
#    cd dotfiles && ./create_symbolic.sh


CMD ["/usr/bin/zsh"]


