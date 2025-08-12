%{
#include "y.tab.h"
%}

%%

[0-9]+          { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval = strdup(yytext); return ID; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MUL; }
"/"             { return DIV; }
"="             { return ASSIGN; }
";"             { return SEMICOLON; }
"("             { return LPAREN; }
")"             { return RPAREN; }
[ \t\r\n]+      { /* ignore whitespace */ }
.               { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
