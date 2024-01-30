# FileName:     opencv
# Author:       8ucchiman
# CreatedDate:  2023-03-27 19:44:58 +0900
# LastModified: 2024-01-20 17:15:41
# Reference:    https://qiita.com/yama07/items/a521234dc91f923ba655
# Description:  


FROM ubuntu:22.04


RUN apt-get update -y && \
    apt-get install -y tzdata
#RUN DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y neofetch git zsh sudo software-properties-common x11-apps cmake g++ wget unzip libgtk2.0-dev pkg-config

#RUN apt-get update && add-apt-repository --yes ppa:xqms/opencv-nonfree && apt-get update && apt-get install libopencv-nonfree-dev
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install -y neovim
RUN apt-get install fzf bat -y
RUN mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat

#RUN echo "root:root" | chpasswd && \
#    adduser --disabled-password --gecos "" "${username}" && \
#    echo "${username}:${username}" | chpasswd && \
#    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${username} && \
#    chmod 0440 /etc/sudoers.d/${username}

RUN sed -i -e 's/%sudo\tALL=(ALL:ALL) ALL/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers


# build opencv
ENV OPENCV_VERSION=4.7.0

USER ${USER_NAME}
WORKDIR /tmp
RUN wget -q -O opencv.zip https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
    wget -q -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip && \
    unzip opencv.zip && \
    unzip opencv_contrib.zip && \
    mkdir -p  build && \
    cd build && \
    cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-${OPENCV_VERSION}/modules \
          -DOPENCV_ENABLE_NONFREE=ON \
          ../opencv-${OPENCV_VERSION} && \
    cmake --build . && \
    sudo make install
RUN sudo ldconfig -v


#RUN mkdir /home/${USER_NAME}/git && cd /home/${USER_NAME}/git && \
#    git clone https://github.com/Bucchiman/public_dotfiles.git dotfiles && \
#    cd dotfiles && ./create_symbolic.sh



COPY entrypoint.sh /root/docker/

RUN chmod +x /root/docker/entrypoint.sh
ENTRYPOINT ["/root/docker/entrypoint.sh"]
