FROM osrf/ros:humble-desktop

RUN apt-get update && apt-get install -y neofetch git zsh sudo software-properties-common x11-apps wget unzip
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install -y neovim
RUN apt-get install fzf bat -y
RUN mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat
RUN apt-get install -y ros-humble-gazebo-ros-pkgs ros-humble-ros-core ros-humble-geometry2
RUN apt-get install -y python3-venv



#RUN echo "root:root" | chpasswd && \
#    adduser --disabled-password --gecos "" "${username}" && \
#    echo "${username}:${username}" | chpasswd && \
#    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${username} && \
#    chmod 0440 /etc/sudoers.d/${username}

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}
#RUN mkdir /home/${USER_NAME}/git && cd /home/${USER_NAME}/git && \
#    git clone https://github.com/Bucchiman/public_dotfiles.git dotfiles && \
#    cd dotfiles && ./create_symbolic.sh

RUN python3 -m venv venv
#RUN source /home/${USER_NAME}/venv/bin/activate && \
#    pip3 install colcon-argcomplete.zsh

#RUN expect /mnt/b/git/base_docker/cargo.tcl


CMD ["/usr/bin/zsh"]

