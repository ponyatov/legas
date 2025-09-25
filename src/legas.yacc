%{
    #include "legas.hpp"
%}

%defines %union { char c; std::string* s; int n; float f; }

%token<n>  INT
%token<f>  NUM
%token     COLON
%token<s>  ID

%%
syntax: | syntax ex

ex: NUM      { fprintf(stderr,"\tnum:%e\n",$1); }
  | INT      { fprintf(stderr,"\tint:%i\n",$1); }
  | COLON ID { fprintf(stderr,"\t   :%s\n",$2->c_str()); }

%%
void yyerror(const char *msg) {
    fprintf(stderr, "\n\n%s:%i %s [%s]\n\n", yyfile, yylineno, msg, yytext);
    exit(-1);
}
