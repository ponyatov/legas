#include "hpp.hpp"

Multiboot multiboot __attribute__((section(".multiboot"))){
    //
    0x1BADB002,  ///< magic: multiboot1
    0x00000000,  ///< flags: none
    0x0          ///< checksum
};
