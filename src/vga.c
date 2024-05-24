#include "hpp.h"

uint8_t __attribute__((section(".vga")))  //
VGA[80 * 25 * 2];

const uint8_t hello[] = "Hello";

void vga() {
    for (int i = 0; i < sizeof(VGA); i++) VGA[i] = hello[i * 2];
}
