set(NAME af80_func_SETUP_WRAPPER)

set(CMAKE_ASM_CREATE_SHARED_LIBRARY ${CMAKE_C_CREATE_SHARED_LIBRARY})

add_library(${NAME}
        af80_func_SETUP_WRAPPER.s
)

target_include_directories(${NAME} INTERFACE
        .
)

target_include_directories(${NAME} PRIVATE
        .
)
