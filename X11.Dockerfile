# FileName: X11
# Author: 8ucchiman
# CreatedDate: 2023-01-26 17:47:21 +0900
# LastModified: 2023-01-26 17:47:56 +0900
# Reference: 8ucchiman.jp


FROM alpine

RUN apk --no-cache add zsh xeyes
CMD ["/bin/zsh"]

