FROM ubuntu:22.04

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y gosu tzdata fonts-noto-cjk
RUN apt-get update && apt-get install -y neofetch git zsh sudo x11-apps vim wget eog cmake build-essential pkg-config libssl-dev libtbb-dev libxcb-xrm-dev libxcb-image0 libxcb-image0-dev libxcb-res0-dev libx11-dev libxinerama-dev libxft-dev libx11-xcb-dev libvips-dev libsixel-dev
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install neovim -y
RUN apt-get install fzf bat -y
RUN mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat

ENV SHELL=/usr/bin/zsh

RUN sed -i -e 's/%sudo\tALL=(ALL:ALL) ALL/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers


#USER ${USER_NAME}
#WORKDIR /home/${USER_NAME}
#RUN mkdir ~/git && cd ~/git && \
#    git clone https://github.com/Bucchiman/dotfiles.git && \
#    cd dotfiles && ./create_symbolic.sh

COPY entrypoint.sh /root/docker/

RUN chmod +x /root/docker/entrypoint.sh
ENTRYPOINT ["/root/docker/entrypoint.sh"]

