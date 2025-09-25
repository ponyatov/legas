%{
    #include "legas.hpp"
%}

%defines %union { char c; std::string* s; int n; float f; }

%token<n> INT
%token<f> NUM

%%
syntax: | syntax ex

ex: NUM     { fprintf(stderr,"num:%e\n",$1); }
  | INT     { fprintf(stderr,"int:%i\n",$1); }

%%
void yyerror(const char *msg) {
    fprintf(stderr, "\n\n%s:%i %s [%s]\n\n", yyfile, yylineno, msg, yytext);
    exit(-1);
}
