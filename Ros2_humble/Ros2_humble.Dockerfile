FROM bucchiman/core:latest AS core

FROM osrf/ros:humble-desktop

RUN apt-get install -y \
    ros-humble-gazebo-ros-pkgs \
    ros-humble-ros-core ros-humble-geometry2
RUN apt-get install -y python3-venv

RUN python3 -m venv venv
#RUN source /home/${USER_NAME}/venv/bin/activate && \
#    pip3 install colcon-argcomplete.zsh

#RUN expect /mnt/b/git/base_docker/cargo.tcl


CMD ["/usr/bin/zsh"]

