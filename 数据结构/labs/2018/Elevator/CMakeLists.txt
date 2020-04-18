# cmake_minimum_required(VERSION <specify CMake version here>)
project(Elevator)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(Elevator
        elevator.cpp
        elevator.hpp
        event.hpp
        main.cpp
        person.hpp)
