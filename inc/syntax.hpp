/// @defgroup syntax syntax
/// @ingroup main
/// @{

#pragma once

#include "os.hpp"
#include <string>

/// @name lexer
/// @{
extern int yylex();   ///< lexer (`flex`)
extern int yylineno;  ///< current line
extern char *yyfile;  ///< current file name
extern FILE *yyin;    ///< current file handler
extern char *yytext;  ///< token lexeme value

/// @brief construct token `(Class,ID)`
/// @param[in] C class name: calls `C(char*)` constructor
/// @param[in] X .yacc token identifier
#define TOKEN(C, X)               \
    {                             \
        yylval.o = new C(yytext); \
        return X;                 \
    }
/// @}

/// @name number parsers
/// @{
extern float num(char *val);  ///< @returns float
extern int dec(char *val);    ///< @returns decimal
extern int hex(char *val);    ///< @returns hexadecimal
extern int oct(char *val);    ///< @returns octal
extern int bin(char *val);    ///< @returns binary
/// @}

/// @name parser
/// @{
extern int yyparse();                  ///< parser (`bison`)
extern void yyerror(const char *msg);  ///< syntax error callback

#include "legas.yacc.hpp"
/// @}

/// @brief process script file
/// @param[in] filename
extern void cli(char *filename);

/// @}
