#include "os.hpp"

__attribute__((weak)) void setup() { 
    printf("setup: ");
    printf("ok\n");
}

__attribute__((weak)) void loop() {  //
    printf("loop: ");
    printf("stop\n");
    exit(0);
}
