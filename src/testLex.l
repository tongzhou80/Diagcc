%{
    int nchar, nword, nline;
    #define file_name 1
%}
filename                    [a-zA-Z0-9_]+\.[c|cpp]
number                      [0-9]+
error_word                 error|warning|note
%%

{filename}:{number}:{number}:[ ]             {printf("file");}
{error_word}:                            {printf("word");}
\^\n                               {printf("cursor\n");}
.|\n                                        {printf("%s", yytext);}
%%
int yywrap(void) {return 1;}


int main(void) {
    yylex();
    
    return 0;
}