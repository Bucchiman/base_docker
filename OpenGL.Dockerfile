#
# FileName:     OpenGL
# Author:       8ucchiman
# CreatedDate:  2023-05-19 18:32:21
# LastModified: 2023-01-26 17:46:51 +0900
# Reference:    8ucchiman.jp
# Description:  ---
#



FROM nvidia/opengl:base

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN apt-get update && apt-get install -y neofetch git zsh sudo x11-apps vim g++ curl unzip
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install neovim -y
RUN apt-get install fzf bat -y
RUN mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat

RUN apt-get install -y cmake pkg-config
RUN apt-get install -y mesa-utils libglu1-mesa-dev freelut3-dev mesa-common-dev
RUN apt-get install -y libglew-dev libglfw3-dev libglm-dev
RUN apt-get install -y libao-dev libmpg123-dev libxi-dev


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
RUN mkdir ~/git && cd ~/git && \
    git clone https://github.com/Bucchiman/public_dotfiles.git && \
    cd public_dotfiles && ./create_symbolic.sh

RUN cd /usr/local/lib/ && git clone https://github.com/glfw/glfw.git && cd glfw && cmake . && make && make install


CMD ["/usr/bin/zsh"]
