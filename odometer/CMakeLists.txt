cmake_minimum_required(VERSION 3.22.1 FATAL_ERROR)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_CXX_FLAGS_DEBUG "-Og -ggdb3")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

project(odometer)

add_subdirectory(src)
