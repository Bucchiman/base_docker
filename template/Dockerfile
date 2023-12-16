FROM pytorch/pytorch:1.12.1-cuda11.3-cudnn8-devel

ENV PYTORCH_VERSION=1.12.1

ENV TZ=Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  gosu \
  tzdata \
  fonts-noto-cjk \
  sudo

# TimeZone を設定
RUN echo $TZ > /etc/timezone \
  && rm /etc/localtime \
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata

# TorchVision をコピー
COPY . /workspace/torchvision

# 必要な Python ライブラリをインストール
RUN pip install cython pycocotools matplotlib

# ENTRYPOINT の設定
RUN chmod +x /workspace/torchvision/docker/entrypoint.sh
ENTRYPOINT ["/workspace/torchvision/docker/entrypoint.sh"]
