FROM osrf/ros:noetic-desktop-full

RUN apt-get update && apt-get install -y neofetch git zsh sudo software-properties-common x11-apps
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install -y neovim
RUN apt-get install fzf bat -y
# https://akatsuki1024.hatenablog.com/entry/2020/12/18/145803
RUN apt-get install python3-catkin-tools
RUN mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat



#RUN echo "root:root" | chpasswd && \
#    adduser --disabled-password --gecos "" "${username}" && \
#    echo "${username}:${username}" | chpasswd && \
#    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${username} && \
#    chmod 0440 /etc/sudoers.d/${username}


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
RUN mkdir /home/${USER_NAME}/git && cd /home/${USER_NAME}/git && \
    git clone https://github.com/Bucchiman/dotfiles.git && \
    cd dotfiles && ./create_symbolic.sh


CMD ["/usr/bin/zsh"]

