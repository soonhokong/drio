/* Author: Jichao Sun <jichaos@andrew.cmu.edu>
 * Copyright 2014 Jichao Sun
 */

#pragma once
// Defining yyFlexLexer
#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

// Changing default yylex function
#undef YY_DECL
#define YY_DECL int shell::scanner::yylex()

#include "shell/parser.tab.hh"

namespace shell{

class scanner : public yyFlexLexer{
public:
    scanner(std::istream *in) :  yyFlexLexer(in),
                                                 yylval(nullptr){};

    int yylex(shell::parser::semantic_type *lval){
        yylval = lval;
        return(yylex());
    }
private:
    int yylex();

    // yylval is now a pointer to a union
    shell::parser::semantic_type *yylval;
};
}
