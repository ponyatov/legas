set(CMAKE_SYSTEM_NAME       Generic)
set(CMAKE_SYSTEM_PROCESSOR  avr)
set(TOOLCHAIN_PREFIX        avr-none)
set(CMAKE_CROSS_COMPILING   true)
set(CMAKE_EXECUTABLE_SUFFIX ".elf")

include(any_toolchain)

add_compile_definitions(AVR NONE)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
add_compile_options()
add_link_options()
