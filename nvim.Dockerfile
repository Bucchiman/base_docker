#
# FileName:     nvim
# Author:       8ucchiman
# CreatedDate:  2023-08-29 12:47:50
# LastModified: 2023-01-26 17:46:51 +0900
# Reference:    https://gist.github.com/mlow/e381292da7521561fe723ac4bdc59275
#               https://www.reddit.com/r/neovim/comments/157x1ba/containerized_neovim/
# Description:  ---
#


# Example usage
#
# $ cp Dockerfile .config/nvim
# $ docker build .config/nvim -t mynvim
#
# # in your .bashrc or .bash_aliases
# nvim() {
#     docker run -it \
#         --network host \
#         -v ~/.ssh:/home/me/.ssh:ro \
#         # The following for wayland system clipboard to work (also install wl-clipboard in the container!)
#         -v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}
#         -e WAYLAND_DISPLAY
#         -e XDG_RUNTIME_DIR
#         # The following if you need ssh-agent
#         -v $SSH_AUTH_SOCK:/ssh-agent \
#         -e SSH_AUTH_SOCK=/ssh-agent \
#         # All project dirs and files to mount
#         $(for dir in "$@"; do echo -n "-v $(realpath $dir):/home/me/workspace/$(basename $dir) "; done) \
#         mynvim:latest
# }
#
# $ nvim path/to/file path/to/directory ...
FROM debian:12

# Install widely used packages
RUN apt-get update -q \
    && apt-get install -yq --no-install-recommends \
        git \
        unzip \
        curl \
        bash-completion \
        kitty-terminfo \
        gettext \
        gettext-base \
        build-essential \
        cmake \
        mason \
        ninja-build \
        openssh-client \
        ca-certificates

# Install more packages
#RUN apt-get install -yq --no-install-recommends
#        golang \
#        rust-all \
#        python3-venv \

# Cleanup apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=$UID
ARG USER=me
ARG HOME=/home/${USER}

# Create our user
RUN groupadd -g ${GID} me \
    && useradd -m -u ${UID} -g me -s /bin/bash me \
    #&& usermod -aG docker me \
    && mkdir ${HOME}/workspace

USER ${USER}

ENV PATH=$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ARG NVIM_VERSION=0.9.1
ARG NVIM_SRC_TARBALL=$HOME/.local/src/neovim-${NVIM_VERSION}.tar.gz

# Fetch, compile, install neovim
RUN mkdir -p $HOME/.local/src \
    && curl -Lo ${NVIM_SRC_TARBALL} \
        https://github.com/neovim/neovim/archive/refs/tags/v${NVIM_VERSION}.tar.gz \
    && tar -xvf ${NVIM_SRC_TARBALL} -C ${HOME}/.local/src/ \
    && cd ${HOME}/.local/src/neovim-${NVIM_VERSION} \
    && make CMAKE_INSTALL_PREFIX=${HOME}/.local/ CMAKE_BUILD_TYPE=RelWithDebInfo \
    && make install

# Copy neovim configuration
COPY --chown=me ./ $HOME/.config/nvim/

# Run neovim twice, the first time bootstraps packer and downloads plugins. The
# second run installs all of our treesitter languages. Assumes paacker has been
# configured to "auto bootstrap"
# See: https://github.com/wbthomason/packer.nvim#bootstrapping
RUN nvim --headless -c \
        'autocmd User PackerComplete quitall' 2> /dev/null \
    && nvim --headless -E +'TSUpdateSync' +'sleep 15' +'quit'

# For lazy.nvim (untested, probably needs tweaking)
#RUN nvim --headless -E +'Lazy! sync' +qa \
#    && nvim --headless -E +'TSUpdateSync' +'sleep 15' +qa

WORKDIR ${HOME}/workspace

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["."]

