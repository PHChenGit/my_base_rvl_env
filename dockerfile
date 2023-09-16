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
        gcc

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
    make -j8 && \
    make install

RUN python -m pip install opencv-python
# RUN apt-get install python3-opencv 

WORKDIR /app

CMD ["tail", "-f", "/dev/null"]