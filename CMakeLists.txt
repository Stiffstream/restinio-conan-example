cmake_minimum_required(VERSION 2.8)

project(restinio_examples)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

add_executable(hello_world_minimal hello_world_minimal.cpp)

target_link_libraries(hello_world_minimal ${CONAN_LIBS})
