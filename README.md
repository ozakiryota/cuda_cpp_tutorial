# cuda_cpp_tutorial

## Installation
### Build locally
Requirements:
* gcc
* cmake
* nvidia-cuda-toolkitnvidia-cuda-toolkit
* ([NVIDIA Nsight Systems](https://mainer.nvidia.com/nsight-systems))

```bash
git clone https://github.com/ozakiryota/cuda_cpp_tutorial.git
mkdir -p cuda_cpp_tutorial/build
cd cuda_cpp_tutorial/build
cmake ..
make
```

### Build with Docker
Requirements:
* Docker

```bash
git clone https://github.com/ozakiryota/cuda_cpp_tutorial.git
cd cuda_cpp_tutorial/docker
./build.sh
```

## Contents
1. [hello_world.cu](https://github.com/ozakiryota/cuda_cpp_tutorial/blob/main/src/hello_world.cu)
    * [hello_world_ng.cu](https://github.com/ozakiryota/cuda_cpp_tutorial/blob/main/src/hello_world_ng.cu)
1. [print_indicies.cu](https://github.com/ozakiryota/cuda_cpp_tutorial/blob/main/src/print_indicies.cu)
1. [print_array.cu](https://github.com/ozakiryota/cuda_cpp_tutorial/blob/main/src/print_array.cu)
    * [print_array_ng.cu](https://github.com/ozakiryota/cuda_cpp_tutorial/blob/main/src/print_array_ng.cu)
1. [print_array_with_gridstrideloop.cu](https://github.com/ozakiryota/cuda_cpp_tutorial/blob/main/src/print_array_with_gridstrideloop.cu)
1. [print_device_properties.cu](https://github.com/ozakiryota/cuda_cpp_tutorial/blob/main/src/print_device_properties.cu)
1. [how_to_configure_grid.cu](https://github.com/ozakiryota/cuda_cpp_tutorial/blob/main/src/how_to_configure_grid.cu)
1. [print_array_with_prefetch.cu](https://github.com/ozakiryota/cuda_cpp_tutorial/blob/main/src/print_array_with_prefetch.cu)
1. [over_max_threads_with_errorcheck.cu](https://github.com/ozakiryota/cuda_cpp_tutorial/blob/main/src/over_max_threads_with_errorcheck.cu)
    * [over_max_threads.cu](https://github.com/ozakiryota/cuda_cpp_tutorial/blob/main/src/over_max_threads.cu)

## Usage
1. Create/edit codes
2. Build
```bash
cd cuda_cpp_tutorial/build
nvcc ../src/hello_world.cu -o hello_world
```
or
```bash
cd cuda_cpp_tutorial/build
cmake ..
make
```
3. Execute
```bash
cd cuda_cpp_tutorial/build
./hello_world
```
4. Profile
```bash
cd cuda_cpp_tutorial/build
nsys profile --stats=true ./hello_world
```
