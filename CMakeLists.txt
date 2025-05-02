cmake_minimum_required(VERSION 3.31.2)
project(AsmProject CXX ASM)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

set(CMAKE_ASM_COMPILER ${PREFIX}/bin/aarch64-linux-android-clang++)

set(CMAKE_ASM_FLAGS "")
set(CMAKE_EXE_LINKER_FLAGS "")

set(CMAKE_C_FLAGS "")
set(CMAKE_CXX_FLAGS "")

add_subdirectory(HelloWorld)
add_subdirectory(basic)
