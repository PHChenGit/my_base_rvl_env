FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel AS base

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei

RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        build-essential \
        make \
        cmake \
        git \
        vim \
        wget \
        curl \
        gcc \
        zip \
        unzip \
        tar


# Install Opencv v4.8.0 from source

RUN apt-get install -y \
    libgtk-3-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    gfortran \
    openexr \
    libatlas-base-dev \
    python3-dev \
    python3-numpy \
    libtbb2 \
    libtbb-dev \
    libdc1394-dev \
    libcanberra-gtk-module \
    libcanberra-gtk3-module

WORKDIR /lib
RUN git clone --branch 4.8.0  --depth 1  https://github.com/opencv/opencv.git && \
    git clone --branch 4.8.0  --depth 1  https://github.com/opencv/opencv_contrib.git

RUN mkdir /lib/opencv/build && \
    cd /lib/opencv/build && \
    cmake -DOPENCV_EXTRA_MODULES_PATH=/lib/opencv_contrib/modules .. && \
    make -j4 && \
    make install

RUN python -m pip install opencv-python

### Install ROS noetic
WORKDIR /

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt update && \
    apt install -y ros-noetic-desktop-full
RUN apt install -y \
        python3-rosdep \
        python3-rosinstall \
        python3-rosinstall-generator \
        python3-wstool

RUN mkdir -p ~/catkin_ws/src && \
    cd ~/catkin_ws/src/ && \
    git clone https://github.com/noshluk2/ros1_wiki && \
    cd ~/catkin_ws

ENV ROS_DISTRO noetic
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc 

RUN touch build_ros.sh && echo "catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3" >> build_ros.sh
RUN echo "ALL Done"

CMD ["tail", "-f", "/dev/null"]