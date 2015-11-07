%{
#include "y.tab.h"
%}
arith_op                    [-\+\*/%]
bitwise_op                  [~&^\|]|>>|<<
assign_op                   ({arith_op}|{bitwise_op})?=
%%

"dump"                      {yylval.str = yytext; return dump_command;} 
"clear"                     {yylval.str = yytext; return clear_command;}

[a-z]                       {yylval.id = yytext[0]; return identifier;}
[0-9]+                      {yylval.num = atoll(yytext); return number;}
[ \t\n]                     ;
[\(\)=]                     {return yytext[0];}
[-\+\*/%~&^\|]              {return yytext[0];}
">>"                        {yylval.str = yytext; return right_shift;}
"<<"                        {yylval.str = yytext; return left_shift;}
"+="                        {yylval.str = yytext; return assign_sum;}
"-="                        {yylval.str = yytext; return assign_diff;}
"*="                        {yylval.str = yytext; return assign_pro;}
"/="                        {yylval.str = yytext; return assign_quo;}
"%="                        {yylval.str = yytext; return assign_rem;}
"<<="                       {yylval.str = yytext; return assign_left_shift;}
">>="                       {yylval.str = yytext; return assign_right_shift;}
"&="                        {yylval.str = yytext; return assign_bit_and;}
"^="                        {yylval.str = yytext; return assign_bit_xor;}
"|="                        {yylval.str = yytext; return assign_bit_or;}
;                           {return yytext[0];}
.                           {ECHO; yyerror("invalid charactor");}
"^D"
%%

int yywrap(void) {return 1;}