cmake_minimum_required(VERSION 2.8.3)
project(cuda_cpp_tutorial)
find_package(CUDA)

cuda_add_executable(hello_world src/hello_world.cu)
cuda_add_executable(print_indicies src/print_indicies.cu)