cmake_minimum_required(VERSION 3.13)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(BOARD=pico)
set(PICO_BOARD pico)

#set(CMAKE_BUILD_TYPE=Debug)
#set(PICO_DEOPTIMIZED_DEBUG=1)


# initialize pico-sdk from submodule
# note: this must happen before project()
include(../pico-sdk/pico_sdk_init.cmake)

project(main)

# initialize the Raspberry Pi Pico SDK
pico_sdk_init()

add_compile_options(-Wall
		-Wno-format          # int != int32_t as far as the compiler is concerned because gcc has int32_t as long int
		-Wno-unused-function # we have some for the docs that aren't called
		-Wno-maybe-uninitialized
		-O0
		)

# all of your files
add_executable(main
		main.c
)

#so the sdk can find our lwipopts files
target_include_directories(main PRIVATE
		${CMAKE_CURRENT_LIST_DIR}
		)


# Add pico_stdlib library which aggregates commonly used features
target_link_libraries(main
		hardware_dma
		pico_stdlib
		hardware_i2c

	)

#use usb serial
pico_enable_stdio_usb(main 0)
pico_enable_stdio_uart(main 1)


# create map/bin/hex/uf2 file in addition to ELF.
pico_add_extra_outputs(main)


