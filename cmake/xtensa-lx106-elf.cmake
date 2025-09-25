set(CMAKE_SYSTEM_NAME       Generic)
set(CMAKE_SYSTEM_PROCESSOR  l106)
set(TOOLCHAIN_PREFIX        xtensa-lx106-elf)
set(CMAKE_CROSS_COMPILING   true)
set(CMAKE_EXECUTABLE_SUFFIX ".elf")

include(any_toolchain)

add_compile_options(
#     -mthumb
    -ffunction-sections -fdata-sections
#     -DCORTEX -D${SERIES}
    $<$<COMPILE_LANGUAGE:CXX>:-nostdinc++>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>
    $<$<COMPILE_LANGUAGE:ASM>:-x$<SEMICOLON>assembler-with-cpp>
    $<$<COMPILE_LANGUAGE:ASM>:-MMD>
    $<$<COMPILE_LANGUAGE:ASM>:-MP>
)

# set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
# add_link_options(
#     -mthumb
#     -T ${CMAKE_SOURCE_DIR}/hw/${HW}/${CPU_}x_FLASH.ld
#     --specs=nano.specs
#     -Wl,--start-group -lc -lm -lnosys   -Wl,--end-group
#     -Wl,--start-group -lstdc++ -lsupc++ -Wl,--end-group
#     -Wl,-Map=${CMAKE_PROJECT_NAME}.map -Wl,--gc-sections
# )
