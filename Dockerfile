FROM ubuntu:20.04

# Basic utilities
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    bash \
    build-essential \
    ca-certificates \
    curl \
    docker.io \
    gcc \
    git \
    htop \
    jq \
    locales \
    man \
    net-tools \
    openssl \
    python3 \
    python3-pip \
    rsync \
    software-properties-common \
    ssh \
    sudo \
    systemd \
    systemd-sysv \
    unzip \
    vim \
    wget
    
# Packages required for multi-editor support
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    libxtst6 \
    libxrender1 \
    libfontconfig1 \
    libxi6 \
    libgtk-3-0
    
# Enable passwordless sudo for any user
COPY sudoers /etc/sudoers

# Add coder user
RUN useradd -mUs /bin/bash coder
USER coder

# Install poetry
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3

# Add poetry to path
ENV PATH $PATH:/home/coder/.poetry/bin

# Globally install jupyter
RUN sudo pip3 install jupyterlab

# Install pycharm.
RUN sudo mkdir -p /opt/pycharm
RUN sudo curl -L "https://download.jetbrains.com/product?code=PCC&latest&distribution=linux" | sudo tar -C /opt/pycharm --strip-components 1 -xzvf -

# Add a binary to the PATH that points to the pycharm startup script.
RUN sudo ln -s /opt/pycharm/bin/pycharm.sh /usr/bin/pycharm-community

# Enables Docker starting with systemd
RUN sudo systemctl enable docker

# go to coder home directory
WORKDIR /home/coder

