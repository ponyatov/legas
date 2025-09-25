#include "legas.hpp"

void arg(int argc, char* argv) {  //
    fprintf(stderr, "arg[%i] = <%s>\n", argc, argv);
    yyfile = argv;
    assert(yyin = fopen(yyfile, "r"));
    fclose(yyin);
    yyfile = nullptr;
}
