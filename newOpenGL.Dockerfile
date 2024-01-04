#
# FileName:     Dockerfile
# Author:       8ucchiman
# CreatedDate:  {{_date_}}
# LastModified: 2023-12-25 12:37:34
# Reference:    8ucchiman.jp
# Description:  ---
#


FROM core:latest AS core

FROM nvidia/opengl:base

RUN cd /usr/local/lib/ \
    && sudo git clone https://github.com/glfw/glfw.git \
    && cd glfw && sudo cmake . \
    && sudo make && sudo make install

COPY entrypoint.sh /root/docker/

RUN chmod +x /root/docker/entrypoint.sh
ENTRYPOINT ["/root/docker/entrypoint.sh"]
