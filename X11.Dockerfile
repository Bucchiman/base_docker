# FileName: X11
# Author: 8ucchiman
# CreatedDate: 2023-01-26 17:47:21 +0900
# LastModified: 2023-03-11 16:48:42 +0900
# Reference: 8ucchiman.jp


FROM ubuntu:20.04

ARG uid=1000
ARG gid=1000

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
                    sudo \
                    vim \
                    curl \
                    ca-certificates \
                    && \
    apt-get clean

RUN addgroup --gid ${gid} myuser && \
    adduser --disabled-login --gecos '' --uid ${uid} --gid ${gid} myuser && \
    usermod -G sudo myuser

RUN echo "Defaults:myuser !requiretty" >> /etc/sudoers.d/myuser && \
    echo "myuser ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/myuser && \
    chmod 440 /etc/sudoers.d/myuser

USER myuser

CMD ["/bin/zsh"]
