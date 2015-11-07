%{
#include "y.tab.h"
%}
filename                    [a-zA-Z0-9_]+\.[c|cpp]
number                      [0-9]+
error_word                  error|warning|note
%%

{filename}:{number}:{number}:[ ]            {yylval.str = strdup(yytext); return file_name;}
"error: "                                   {yylval.num = error_t; return error_t;}
"warning: "                                 {yylval.num = warning_t; return warning_t;}
"note: "                                    {yylval.num = note_t; return note_t;}
.|\n                                        {yylval.str = strdup(yytext); return message;}
%%

int yywrap(void) {return 1;}