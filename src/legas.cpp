#include "legas.hpp"

void arg(int argc, char* argv) {  //
    fprintf(stderr, "arg[%i] = <%s>\n", argc, argv);
    if (argc > 0) {
        yyfile = argv;
        assert(yyin = fopen(yyfile, "r"));
        yyparse();
        fclose(yyin);
        yyfile = nullptr;
    }
}
