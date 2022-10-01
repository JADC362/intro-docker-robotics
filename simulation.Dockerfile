# TODO: Start with base ros:galactic-ros-base

ENV DEBIAN_FRONTEND=noninteractive
# TODO: Set the env var QT_X11_NO_MITSHM to be 1

# TODO: Finish installing tools with apt:
# curl, git, gnupg2, vim
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    git \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# TODO: Install ros-gazebo dependencies with apt:
# ros-galactic-gazebo-*, ros-galactic-navigation2, ros-galactic-nav2-bringup
# ros-galactic-dynamixel-sdk, ros-galactic-turtlebot3*
# Note: Don't forget to remove the apt list (/var/lib/apt/lists/*)

# Install models
RUN git clone https://github.com/osrf/gazebo_models.git \
    && sudo cp -rf gazebo_models/* /usr/share/gazebo-11/models \
    && rm -rf gazebo_models

# Add to the Gazebo Env Path GAZEBO_MODEL_PATH the models:
# /usr/share/gazebo-11/models:/opt/ros/galactic/share/turtlebot3_gazebo/models
# Hint: PATH=$PATH:new_path

# Add user `docker`, set password to `docker` and add it to group `sudo`
RUN useradd -m docker -s /bin/bash && echo "docker:docker" | chpasswd && adduser docker sudo
USER docker

# Add ROS paths to docker user
RUN echo "source /opt/ros/galactic/setup.bash" >> /home/docker/.bashrc

# TODO: Set the workind directory to be on /home/docker/dev_ws
