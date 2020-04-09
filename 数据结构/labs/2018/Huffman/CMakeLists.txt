cmake_minimum_required(VERSION 3.10)
project(Huffman)

set(CMAKE_CXX_STANDARD 11)

include_directories(.)

add_executable(Huffman
        huffman.hpp
        myzip.cpp
        )
