FROM ubuntu:18.04

RUN apt-get update && apt-get install -y neovim neofetch git zsh
#RUN chsh -s zsh
#RUN mkdir ~/git && cd ~/git && \
#    git clone https://github.com/Bucchiman/dotfiles.git 
#    && cp dotfiles/.zshrc ~ && cp dotfiles/.config ~
