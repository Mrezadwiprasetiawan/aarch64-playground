add_executable(HelloWorld main.S)

# Tambahkan flag kompilasi untuk menonaktifkan runtime
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -nostartfiles")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -nostartfiles")
