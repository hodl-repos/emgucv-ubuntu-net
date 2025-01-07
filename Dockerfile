FROM ubuntu:22.04

RUN apt-get update 
RUN apt-get install -y software-properties-common sudo wget git
RUN add-apt-repository ppa:dotnet/backports
RUN apt-get update 
RUN apt-get install -y dotnet-sdk-9.0 ffmpeg
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install tzdata

#FROM https://raw.githubusercontent.com/emgucv/emgucv/refs/tags/4.9.0/platforms/ubuntu/22.04/apt_install_dependency
RUN apt-get install -y build-essential libgtk-3-dev libgstreamer1.0-dev libavcodec-dev libswscale-dev libavformat-dev libdc1394-dev libv4l-dev cmake cmake-curses-gui ocl-icd-dev freeglut3-dev libgeotiff-dev libusb-1.0-0-dev libvtk9-dev libfreetype-dev libharfbuzz-dev qtbase5-dev libeigen3-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgflags-dev libgoogle-glog-dev libatlas-base-dev liblapacke-dev libva-dev
RUN apt-get clean 

WORKDIR /mnt/emgu_repo
RUN git clone https://github.com/emgucv/emgucv emgucv
WORKDIR /mnt/emgu_repo/emgucv
RUN git fetch origin 4.9.0
RUN git checkout 4.9.0
RUN git submodule update --init --recursive

WORKDIR /mnt/emgu_repo/emgucv/platforms/ubuntu/22.04
RUN ./apt_install_dependency
RUN ./cmake_configure mini
RUN rm -rf /mnt/emgu_repo
