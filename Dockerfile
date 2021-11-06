FROM ubuntu:18.04

ARG userid=1000
ARG groupid=1000
ARG username=aosp

RUN apt-get update -qqy && \
    apt-get install -qqy git-core gnupg flex bison build-essential \
        zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
        lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev \
        libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update -qqy && \
    apt-get install -qqy openjdk-8-jdk && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update -qqy && \
    apt-get install -qqy python && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && \
    chmod a+x /usr/local/bin/repo

RUN groupadd -g $groupid $username && \
    useradd -m -u $userid -g $groupid $username

USER $username

COPY gitconfig /home/$username/.gitconfig
COPY ssh_config /home/$username/.ssh/config

# The persistent data will be in these two directories, everything else is
# considered to be ephemeral
VOLUME ["/tmp/ccache", "/aosp"]

# Work in the build directory, repo is expected to be init'd here
WORKDIR /aosp

