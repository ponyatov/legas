/// @file
/// @brief Multiboot-compliant
///
/// - https://wiki.osdev.org/Multiboot
/// - https://www.gnu.org/software/grub/manual/multiboot/multiboot.html

#pragma once

#include <cstdint>

struct __attribute__((packed, aligned(4))) Multiboot {
    uint32_t magic;     // required
    uint32_t flags;     // required
    uint32_t checksum;  // required
    // if flags[16] is set
    uint32_t header_addr;
    uint32_t load_addr;
    uint32_t load_end_addr;
    uint32_t bss_end_addr;
    uint32_t entry_addr;
    // if flags[2] is set
    uint32_t mode_type;
    uint32_t width;
    uint32_t height;
    uint32_t depth;
};

extern Multiboot multiboot;
