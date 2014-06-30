/* Author: Jichao Sun <jichaos@andrew.cmu.edu> 
 * Copyright 2014 Jichao Sun
 */

%{
#include <string>
#include <cstdlib>
#include "scanner.h"

#define STOKEN(x) (new std::string(x))
#define NTOKEN(x) ( double (atof(x)) )

typedef shell::parser::token token;

%}

%option debug
%option nodefault
%option yyclass="scanner" 
%option noyywrap 
%option c++

%%
"real"                  { return token::t_real; } 
"int"                   { return token::t_int; }
"print"                 { return token::print; } 
"exit"                  { return token::quit; }
"quit"                  { return token::quit; }
"print environment"     { return token::printenv; }

    /* Variables */
[a-zA-Z]+               {   
                            yylval->var = STOKEN(yytext); 
                            return token::variable;
                        }

    /* operators */
[-+=()*\n/]             { return yytext[0]; }

    /* numbers */
[0-9]*\.?[0-9]+         {
                            yylval->num = NTOKEN(yytext); 
                            return token::number;
                        }

    /* ignore spaces */
[ \t]                   { ; }

    /* everything else */
.                       { printf ("unexpected character"); }

%%

int yywrap (void) {
    return 1;
}