FROM nvidia/cuda:10.2-base-ubuntu18.04

RUN apt-get update && apt-get install -y neofetch git zsh sudo wget
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install neovim -y


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

RUN wget https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh && \
    chmod u+x Anaconda3-5.1.0-Linux-x86_64.sh
#    bash Anaconda3-5.1.0-Linux-x86_64.sh


CMD ["/usr/bin/zsh"]

