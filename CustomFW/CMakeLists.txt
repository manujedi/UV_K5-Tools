cmake_minimum_required(VERSION 3.25)
project(CustomFW C CXX ASM)

set(OPTI_FLAG s)
set(CMAKE_BUILD_TYPE MinSizeRelease)

set(STM32_DEFINES "-DSTM32F0 -DSTM32F030x8 -DSTM32")

set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(CMAKE_TOOLCHAIN_FILE toolchain/arm-none-eabi-gcc.cmake)
include(${CMAKE_TOOLCHAIN_FILE})

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

set(COMPILER_OPTIONS -mthumb -mcpu=cortex-m0 -mfpu=auto -mfloat-abi=soft -fno-exceptions
        -msoft-float -fdata-sections -ffunction-sections -Wall $<$<COMPILE_LANGUAGE:CXX>:-Wno-register> -Wno-unknown-pragmas
        -O${OPTI_FLAG} $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
        $<$<CONFIG:Debug>:--debug -DDEBUG>
        )

add_subdirectory(src)