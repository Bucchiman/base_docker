FROM ubuntu:18.04

RUN apt-get update && apt-get install -y neovim neofetch git zsh

RUN useradd -m bucchiman --uid=1000 && echo "bucchiman:docker" | chpasswd
#RUN chsh -s zsh
#RUN mkdir ~/git && cd ~/git && \
#    git clone https://github.com/Bucchiman/dotfiles.git 
#    && cp dotfiles/.zshrc ~ && cp dotfiles/.config ~

USER 1000:1000
WORKDIR /home/bucchiman
