# install create users, apt dependencies, make sudoers

#FROM debian:buster-20190910
FROM debian:buster-20181112


LABEL maintainer="serhatcevikel@yahoo.com"

# create hadoop user
ENV NB_USER hadoop
ENV NB_UID 1001
ENV HOME /home/${NB_USER}

USER root
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER} && \
    echo "hadoop:hadoop" | chpasswd && \
    usermod -aG sudo ${NB_USER}

# create jovyan user
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

USER root
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER} && \
    echo "jovyan:jovyan" | chpasswd && \
    usermod -aG sudo ${NB_USER}

RUN apt update && \
    apt upgrade -y && \
    apt dist-upgrade -y && \
    apt autoremove -y && \
    apt install -y \
    basex \
    bc \
    ca-certificates-java \
    csvkit \
    curl \
    default-jdk \
    expect \
    git \
    gnupg \
    gnuplot-x11 \
    htop \
    iptables \
    jq \
    less \
    libcairo2-dev \
    libcurl4-gnutls-dev \
    libpq-dev \
    libsasl2-dev \
    libssl-dev \
    libudunits2-dev \
    libunwind-dev \
    libxml2-dev \
    libxml2-utils \
    lynx \
    man \
    manpages \
    moreutils \
    net-tools \
    nmap \
    openssh-server \
    pandoc \
    parallel \
    postgresql \
    python3-pip \
    r-base \
    screen \
    sudo \
    texlive-xetex \
    tidy \
    unixodbc-dev \
    vim \
    wget; \

    # java env variables 
    echo "JAVA_HOME=/usr/lib/jvm/default-java" >> /etc/environment; \

    # screenrc configuration
    echo "startup_message off" >> /etc/screenrc; \

    # make hadoop sudoer with no password prompt
    echo "hadoop ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/hadoop; \
    # make jovyan sudoer with no password prompt
    echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/jovyan; \

    # take care of sh symlink
    if [ -e /usr/bin/sh ]; \
    then \
        rm /usr/bin/sh; \
    fi; \

    ln -s /usr/bin/bash /usr/bin/sh; \

    
