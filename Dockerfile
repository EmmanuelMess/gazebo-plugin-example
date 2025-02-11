FROM ghcr.io/sloretz/ros:jazzy-simulation

ENV HOME="/root"
ENV ROS_DISTRO="jazzy"
ENV WORKSPACE="${HOME}/odometer"

# Install dependencies

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ninja-build \
    gdb \
    wget && \
    rm -rf /var/lib/apt/lists/*

RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
RUN apt-get update && apt-get install -y \
    libgz-cmake4-dev \
    libgz-sensors8-dev  \
    libgz-sim8-dev && \
    rm -rf /var/lib/apt/lists/*

# Append ROS setup script to .bashrc.
RUN echo "export ROS_PACKAGE_PATH=${WORKSPACE}:\${ROS_PACKAGE_PATH}" >> ${HOME}/.bashrc
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ${HOME}/.bashrc

# For loading the plugins
RUN mkdir -p ${HOME}/.gz/sim/plugins

WORKDIR ${WORKSPACE}
