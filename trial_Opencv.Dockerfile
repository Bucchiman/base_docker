#
# FileName:     trial_Opencv
# Author:       8ucchiman
# CreatedDate:  2023-12-16 11:21:11
# LastModified: 2023-12-16 12:47:36
# Reference:    8ucchiman.jp
# Description:  ---
#


FROM bucchiman/base:latest

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
    make install
RUN ldconfig -v


ENV SHELL=/usr/bin/zsh
CMD ["/usr/bin/zsh"]
