set(CMAKE_SYSTEM_NAME       Linux)
set(CMAKE_SYSTEM_PROCESSOR  armv7l)
set(TOOLCHAIN_PREFIX        arm-linux-gnueabihf)
set(CMAKE_CROSS_COMPILING   true)

set(CMAKE_EXECUTABLE_SUFFIX_ASM "")
set(CMAKE_EXECUTABLE_SUFFIX_C   "")
set(CMAKE_EXECUTABLE_SUFFIX_CXX "")

include(any_toolchain)

add_compile_definitions(ARMV7 RPI LINUX)
add_compile_options()
add_link_options()
