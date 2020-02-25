cmake_minimum_required(VERSION 2.8)

project(restinio_examples)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

find_package(restinio CONFIG REQUIRED)

add_executable(hello_world_minimal hello_world_minimal.cpp)

target_link_libraries(hello_world_minimal restinio::restinio)
target_link_libraries(hello_world_minimal ${CONAN_LIBS})

if(WIN32)
    target_link_libraries(hello_world_minimal wsock32 ws2_32)
endif()
