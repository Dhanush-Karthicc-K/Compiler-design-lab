%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_SIZE 100
char *symTable[MAX_SIZE];
int symCount = 0;

void insertSymbol(char *identifier) {
    for (int i = 0; i < symCount; i++) {
        if (strncmp(symTable[i], identifier, MAX_SIZE) == 0)
            return;
    }
    symTable[symCount++] = strdup(identifier);
}
%}

%option noyywrap

%%

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("Identifier: %s\n", yytext);
    insertSymbol(yytext);
}

[0-9]+ {
    printf("Number: %s\n", yytext);
}

[\+\-\*/=<>!&|]+ {
    printf("Operator: %s\n", yytext);
}

\/\/[^\n]* {
    printf("Single-line Comment\n");
}

\/\*([^*]|\*+[^*/])*\*+\/ {
    printf("Multi-line Comment\n");
}

[ \t\r\n]+  {/* skip whitespace */}

. {
    printf("Other: %s\n", yytext);
}

%%

int main() {
    yylex();
    printf("\n--- Symbol Table ---\n");
    for (int i = 0; i < symCount; i++) {
        fprintf(stdout, "%s\n", symTable[i]);
    }
    return 0;
}
