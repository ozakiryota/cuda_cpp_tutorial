########## Pull ##########
FROM nvidia/cuda:11.1.1-base-ubuntu20.04
########## Non-interactive ##########
ENV DEBIAN_FRONTEND=noninteractive
########## Common tool ##########
RUN apt-get update && \
	apt-get install -y \
		vim \
		wget \
		unzip \
		git
########## CUDA ##########
RUN apt-get update && \
    apt-get install -y \
		build-essential \
		cmake \
		nvidia-cuda-toolkit && \
	apt-get remove -y gcc && \
	ln -s /usr/bin/gcc-8 /usr/bin/gcc && \
	ln -s /usr/bin/g++-8 /usr/bin/g++ && \
	ln -s /usr/bin/gcc-8 /usr/bin/cc && \
	ln -s /usr/bin/g++-8 /usr/bin/c++ && \
	cd ~/ && \
	wget https://developer.download.nvidia.com/devtools/repos/ubuntu2004/amd64/nsight-systems-2022.2.1_2022.2.1.31-1_amd64.deb && \
	apt-get install -y ./nsight-systems-2022.2.1_2022.2.1.31-1_amd64.deb
########## Cache busting ##########
ARG CACHEBUST=1
########## Tutorial package ##########
RUN cd ~/ && \
	git clone https://github.com/ozakiryota/cuda_cpp_tutorial.git && \
	mkdir -p cuda_cpp_tutorial/build && \
	cd cuda_cpp_tutorial/build && \
	cmake .. && \
	make  -j $(nproc --all)
########## Initial position ##########
WORKDIR /root/cuda_cpp_tutorial