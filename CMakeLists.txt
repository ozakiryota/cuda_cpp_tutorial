cmake_minimum_required(VERSION 2.8.3)
project(cuda_cpp_tutorial)
find_package(CUDA)

file(GLOB FILE_LIST "src/*.cu")
foreach(FILE_PATH ${FILE_LIST})
  get_filename_component(FILE_NAME ${FILE_PATH} NAME_WE)
  cuda_add_executable(${FILE_NAME} ${FILE_PATH})
endforeach()