
FROM yuqianj/tensorrt-opencv-ros:latest
#Update cuda driver
WORKDIR /home
RUN apt-get update && apt-get -y install wget 
ARG DEBIAN_FRONTEND=noninteractive

# gui access
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt-get update -y

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y dist-upgrade \
    && apt-get -y install build-essential
RUN apt-get install -y --fix-missing wget zip cmake gcc git curl 
# Pangolin
COPY Pangolin /tmp/Pangolin
RUN cd /tmp/Pangolin && mkdir build && cd build && cmake .. \
    && make -j$(nproc) && make install \
    && cd / && rm -rf /tmp/Pangolin
# Eigen
COPY eigen-3.3.9.zip /opt/eigen-3.3.9.zip
RUN cd /opt && unzip eigen-3.3.9.zip  && cd eigen-3.3.9 && mkdir build && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=RELEASE .. \
    && make install

RUN apt-get update && apt install -y libboost-all-dev
RUN apt-get install -y libglew-dev
RUN apt-get install -y cmake
# RUN apt-get install -y libpython2.7-dev
RUN apt-get install -y ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev
RUN apt-get install -y libdc1394-22-dev libraw1394-dev
RUN apt-get install -y libjpeg-dev libtiff5-dev libopenexr-dev
RUN apt install -y software-properties-common


# # #download ddr_orb2
WORKDIR /root
RUN apt-get install -y qt5-default
RUN apt-get install -y libvtk6-dev libgl1-mesa-dev qtdeclarative5-dev


WORKDIR /root/ddr_orb2

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y nano gawk git libcanberra-gtk-module libcanberra-gtk3-module libatlas3-base \
    libgtkglext1 libgtkglext1-dev

# export LD_LIBRARY_PATH=/root/ddr_orb2/ddrnet_trt/:$LD_LIBRARY_PATH
