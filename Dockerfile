FROM ubuntu:20.04

# Basic utilities
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    curl \
    python \
    python-pip \
    wget \
    man \
    htop \
    git \
    vim \
    jq \
    openssh \
    docker \
    gcc \
    net-tools \
    inetutils \
    rsync

# Enable passwordless sudo for any user
COPY sudoers /etc/sudoers

# Add coder user
RUN useradd -mUs /bin/bash coder
USER coder

# Install poetry
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# Add poetry to path
ENV PATH $PATH:/home/coder/.poetry/bin

# Globally install jupyter
RUN sudo pip install jupyterlab

# Install pycharm.
RUN mkdir -p /opt/pycharm
RUN curl -L "https://download.jetbrains.com/product?code=PCC&latest&distribution=linux" | tar -C /opt/pycharm --strip-components 1 -xzvf -

# Add a binary to the PATH that points to the pycharm startup script.
RUN ln -s /opt/pycharm/bin/pycharm.sh /usr/bin/pycharm-community

# go to coder home directory
WORKDIR /home/coder

