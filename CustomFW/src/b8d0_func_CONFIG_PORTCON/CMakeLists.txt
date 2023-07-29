set(NAME b8d0_func_CONFIG_PORTCON)

set(CMAKE_ASM_CREATE_SHARED_LIBRARY ${CMAKE_C_CREATE_SHARED_LIBRARY})

add_library(${NAME}
        b8d0_func_CONFIG_PORTCON.s
)

target_include_directories(${NAME} INTERFACE
        .
)

target_include_directories(${NAME} PRIVATE
        .
)
