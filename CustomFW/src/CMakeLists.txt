add_subdirectory(b8d0_func_CONFIG_PORTCON)
add_subdirectory(af80_func_SETUP_WRAPPER)

set(NAME main)
set(MCU_TARGET_FILES_DIR ../mcu_target_common)

add_executable(main
        main.c
        af80_func_SETUP_WRAPPER/af80_func_SETUP_WRAPPER.s
        b8d0_func_CONFIG_PORTCON/b8d0_func_CONFIG_PORTCON.s
)


target_include_directories(${NAME} PUBLIC
        ./
        Drivers/CMSIS/Device/ST/STM32G0xx/Include
        Drivers/CMSIS/DSP/Include
        Drivers/CMSIS/Include
)

target_compile_definitions(${NAME} PRIVATE
        ${STM32_DEFINES}
        $<$<CONFIG:Debug>:DEBUG_ENABLED>
)

target_compile_options(${NAME} PRIVATE
        ${COMPILER_OPTIONS}
        -flto
)

target_link_options(${NAME} PRIVATE
        #-print-multi-lib
        -T ${CMAKE_CURRENT_SOURCE_DIR}/symbols.ld
        -flto
        -mcpu=cortex-m0
        -mthumb
        -mfpu=auto
        -mfloat-abi=soft
        -specs=nosys.specs
        -specs=nano.specs
        -lc
        -lm
        -lnosys
        -Wl,-Map=${PROJECT_NAME}.map,--cref
        -Wl,--gc-sections
        -Wl,--print-memory-usage
        -Wstack-usage=128
        -Wno-register
)