#
# FileName:     Dockerfile
# Author:       8ucchiman
# CreatedDate:  2025-11-25 14:24:14
# LastModified: 2025-11-26 21:14:46
# Reference:    
# Description:  ---
#


# ベースイメージ（Ubuntu 22.04）
FROM ubuntu:22.04

# 環境変数
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Tokyo


# http_proxy="http://172.17.0.1:3128" -e https_proxy="http://172.17.0.1:3128" -e ftp_proxy="http://172.17.0.1:3128" -e no
# _proxy="localhost,127.0.0.1,::1"
RUN echo 'Acquire::http::Proxy "http://172.17.0.1:3128";'  >  /etc/apt/apt.conf.d/80proxy && \
    echo 'Acquire::https::Proxy "http://172.17.0.1:3128";' >> /etc/apt/apt.conf.d/80proxy


# 基本パッケージ
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    wget \
    git \
    vim \
    ca-certificates \
    neovim \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリ
WORKDIR /app

# ホストのファイルをコピー
COPY . /app

# ENTRYPOINT または CMD
ENTRYPOINT ["bash"]
# CMD []
