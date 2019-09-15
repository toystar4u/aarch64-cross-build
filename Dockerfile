#
#

FROM ubuntu:16.04
LABEL maintainer="toystar@gmail.com"
LABEL version="1.0"
LABEL description=" aarch64 cross-build environment(debian9 rootfs)"

# Upgrade system and Yocto Project basic dependenies
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat cpio python python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping libsdl1.2-dev xterm curl

# Setup locale
#RUN apt-get -y install locales apt-utils sudo
#RUN dpkg-reconfigure locales 
#RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 
#ENV LANG en_US.utf8

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Replace dash with bash
RUN rm /bin/sh && ln -s bash /bin/sh

# User management (add user name= build, group= build)
RUN groupadd -g 1000 build
RUN useradd -u 1000 -g 1000 -ms /bin/bash build

# add supplementary group, sudo and users to build user
# If you need to add a user to any one of the supplementary group, you can use the options ‘-a‘ and ‘-G
RUN usermod -a -G sudo build
RUN usermod -a -G users build


# Run as build user from the installation path
ENV YOCTO_INSTALLATION_PATH "/opt/yocto"
RUN install -o 1000 -g 1000 -d ${YOCTO_INSTALLATION_PATH}
USER build 
WORKDIR /home/build



# Install Poky
RUN git clone https://toystar@bitbucket.org/toystar/underwatercomm_rootfs.git

# Install FSL community BSP
RUN cd underwatercomm_rootfs
RUN tar -xvf underwater-rootfs-vanilla.tgz
RUN rm -rf ./underwater-rootfs-vanilla.tgz ./.git ./README.md

# Make /home/build the working directory
WORKDIR /home/build
