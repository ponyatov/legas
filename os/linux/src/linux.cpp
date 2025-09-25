#include "os.hpp"

__attribute__((weak)) int main(int argc, char* argv[]) {
    arg(0, argv[0]);
    setup();
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
    }
    loop();
    return 0;
}

__attribute__((weak)) void arg(int argc, char* argv) {  //
    fprintf(stderr, "arg[%i] = <%s>\n", argc, argv);
}
