#
# FileName:     mysql
# Author:       8ucchiman
# CreatedDate:  2023-05-08 13:15:36
# LastModified: 2023-01-26 17:46:51 +0900
# Reference:    https://hub.docker.com/_/mysql
# Description:  ---
#


FROM mysql:debian


RUN apt-get update && apt-get install -y neofetch git zsh sudo x11-apps vim wget eog
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install neovim -y
RUN apt-get install fzf bat -y
RUN mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat

# RUN apt-get install mysql-server

ENV SHELL=/usr/bin/zsh

CMD ["/usr/bin/zsh"]
