#!/bin/bash

xhost +

image="cuda_cpp_tutorial"
tag="latest"

docker run -it --rm \
	-e "DISPLAY" \
	-v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	-v $(pwd)/../src:/root/$image/src \
	--gpus all \
	$image:$tag