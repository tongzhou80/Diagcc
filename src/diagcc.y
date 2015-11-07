%{
void yyerror(char* s);
extern int yylineno;
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "util.h"

void color(char* file, int e_t, char* msg);
%}

%union {int num; char id; char* str;}
%start text
%token <str> file_name message
%token <num> error_t warning_t note_t number 
%type <str> error_block messages
%type <num> error_type

%%

text            : error_block               {;}
                | text error_block          {;}
                ;

error_block     : file_name error_type messages    {color($1, $2, $3);}
                ;

error_type      : error_t                   {;}  /* $$ defaults to $1 */
                | warning_t                 {;}
                | note_t                    {;}
                ;

messages        : message                   {$$ = strdup($1);}
                | messages message          {$$ = my_concate($1, $2);}
                ;

%%

void color(char* file, int e_t, char* msg) {
    /* color filename, line number */
    set_highlight();
    printf("%s", file);

    /* color error type word */
    switch(e_t){
        case error_t: 
            set_color("red");
            printf("error: ");
            break;

        case warning_t: 
            set_color("purple");
            printf("warning: ");
            break;

        case note_t: 
            set_color("cyan");
            printf("note: ");
            break;
    }
    clear_prop();

    /* color words in quotation and cursor 
     * 
     * Some non-ascii character is included in gcc's diagnostic message
     * '‘' is made up of three char: -30, -128, -104
     * '’' is made up of three char: -30, -128, -103
     */
    for (int i = 0; i < strlen(msg); ++i)
    {
        if (msg[i] == '^')
        {
            set_highlight();
            set_color("green");
            printf("%c", msg[i]);
            clear_prop();
        }
        else if (msg[i] == -30) {
            set_highlight();
            printf("%c", msg[i]);           
        }
        else if (msg[i] == -103) {
            printf("%c", msg[i]); 
            clear_prop();
        }
        else {
            printf("%c", msg[i]);
        }
    }
    
}

int main() {
    yyparse();
    return 0;
}

void yyerror(char* s) {
    fprintf(stderr, "line %d: %s\n", yylineno, s);
}