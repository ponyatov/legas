%{
    #include "legas.hpp"
    char *yyfile = nullptr;
%}

%option noyywrap yylineno

s     [+\-]
n     [0-9]
alpha [a-zA-Z_]
alnum [a-zA-Z_0-9]

/* special states for block comments */
%x STACK COMMENT

%%
"#!"[^\n]+              {}                              // shebang
"//"[^\n]+              {}                              // line comment
[ \t\r\n]+              {}                              // drop spaces

"/*"                    {BEGIN(COMMENT);}               // start block comment
<COMMENT>"*/"           {BEGIN(INITIAL);}               // end stack notation
<COMMENT>.              {}                              // ignore any chars

"("                     {BEGIN(STACK  );}               // start stack notation
<STACK>")"              {BEGIN(INITIAL);}               // end stack notation
<STACK>.                {}                              // ignore any chars

{s}?{n}+[eE]{s}?{n}+    {yylval.f = atof(yytext); return NUM;}   // float
{s}?{n}+\.{n}+          {yylval.f = atof(yytext); return NUM;}   // float
{s}?{n}+                {yylval.n = atoi(yytext); return INT;}   // integer

":"                     {return COLON;}
{alpha}{alnum}*         {yylval.s = new std::string(yytext); return ID; }

[ \t\r\n]+              {}                              // drop spaces
.                       {yyerror("");}                  // any undetected char
