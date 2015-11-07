%{
void yyerror(char* s);
extern int yylineno;
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#define symbol_num 26
int symbols[symbol_num];
int getSymbolVal(char symbol);
int setSymbolVal(char symbol, int val);

int add(int a, int b);
int subtract(int a, int b);
int multiply(int a, int b);
int divide(int a, int b);
int modulo(int a, int b);

int detectOverflow(int a, int b);
int echo(int val);
int error_flag = 0;
char* error_message;
void dump();
void clear();
%}

%union {long long num; char id; char* str;}
%start line
%token <num> number
%token <id> identifier
%token <str> dump_command clear_command
%token <str> left_shift right_shift 
%token <str> assign_sum assign_diff assign_pro assign_quo assign_rem assign_left_shift assign_right_shift assign_bit_and assign_bit_xor assign_bit_or

%type <num> line statement assignment exp
%type <num> exp1 exp2 exp3 exp4 exp5 exp6 exp7 exp8

%%

line        : statement                             {;}
            | line statement                        {;} 
            ;

statement   : assignment ';'                        {echo($1);}
            | dump_command ';'                      {dump();}
            | clear_command ';'                     {clear();}
            | exp1 ';'                              {echo($1);}
            ;

assignment  : identifier '=' exp                    {setSymbolVal($1, $3); $$ = getSymbolVal($1);}
            | identifier assign_sum exp             {setSymbolVal($1, add($1,$3)); $$ = getSymbolVal($1);}
            | identifier assign_diff exp            {setSymbolVal($1, subtract(getSymbolVal($1),$3)); $$ = getSymbolVal($1);}
            | identifier assign_pro exp             {setSymbolVal($1, multiply(getSymbolVal($1),$3)); $$ = getSymbolVal($1);}
            | identifier assign_quo exp             {setSymbolVal($1, divide(getSymbolVal($1),$3)); $$ = getSymbolVal($1);}
            | identifier assign_rem exp             {setSymbolVal($1, modulo(getSymbolVal($1),$3)); $$ = getSymbolVal($1);}
            | identifier assign_left_shift exp      {setSymbolVal($1, getSymbolVal($1)<<$3); $$ = getSymbolVal($1);}
            | identifier assign_right_shift exp     {setSymbolVal($1, getSymbolVal($1)>>$3); $$ = getSymbolVal($1);}
            | identifier assign_bit_and exp         {setSymbolVal($1, getSymbolVal($1)&$3); $$ = getSymbolVal($1);}
            | identifier assign_bit_xor exp         {setSymbolVal($1, getSymbolVal($1)^$3); $$ = getSymbolVal($1);}
            | identifier assign_bit_or exp          {setSymbolVal($1, getSymbolVal($1)|$3); $$ = getSymbolVal($1);}           
            ;

exp         : exp1                                  {$$ = $1;}
            | assignment                            {$$ = $1;}
            ;

exp1        : exp2                                  {$$ = $1;}
            | exp1 '|' exp2                         {$$ = $1 | $3;}
            ;

exp2        : exp3                                  {$$ = $1;}
            | exp2 '^' exp3                         {$$ = $1 ^ $3;}
            ;

exp3        : exp4                                  {$$ = $1;}
            | exp3 '&' exp4                         {$$ = $1 & $3;}
            ;

exp4        : exp5                                  {$$ = $1;}
            | exp4 right_shift exp5                 {$$ = $1 >> $3;}
            | exp4 left_shift exp5                  {$$ = $1 << $3;}
            ;

exp5        : exp6                                  {$$ = $1;}
            | exp5 '+' exp6                         {$$ = add($1, $3);}
            | exp5 '-' exp6                         {$$ = subtract($1, $3);}
            ;

exp6        : exp7                                  {$$ = $1;}
            | exp6 '*' exp7                         {$$ = multiply($1, $3);}
            | exp6 '/' exp7                         {$$ = divide($1, $3);}
            | exp6 '%' exp7                         {$$ = modulo($1, $3);}
            ;

exp7        : exp8                                  {$$ = $1;}
            | '~' exp7                              {$$ = ~$2;}
            | '-' exp7                              {$$ = -$2;}         
            ;

exp8        : number                                {$$ = getNumberValue($1);}
            | identifier                            {$$ = getSymbolVal($1);}
            | '(' exp ')'                           {$$ = $2;}         
            ;

%%

int getNumberValue(long long raw_num) { 
    if (raw_num > INT_MAX || raw_num < INT_MIN)
    {
        error_flag = 1;
        error_message = "overflow";
    }
    else {
        return (int)raw_num;
    }
}

int computeSymbolIndex(char token) {
    int idx = -1;
    idx = token - 'a';
    return idx;
}

int getSymbolVal(char symbol) {
    int index = computeSymbolIndex(symbol);
    return symbols[index];
}

int setSymbolVal(char symbol, int val) {
    if (error_flag == 0) {
        int index = computeSymbolIndex(symbol);
        symbols[index] = val;
    }
    else {
        /* do not update when an error is detected */
    }
}

int add(int a, int b) {
    if ((b > 0 && a > INT_MAX - b) || (b < 0 && a < INT_MIN - b)) {
        error_flag = 1;
        error_message = "overflow";
        return 0; // won't have any affect. An error will prevent updating value.
    }
    else
        return a+b;
}

int subtract(int a, int b) {
    if (a>0 && b<0)
        return add(a, -b);
    else if (a<0 && b>0)
        return -add(-a, b);
    else
        return a-b;
}

int multiply(int a, int b) {
    if ((b > 0 && a > INT_MAX / b) || (b < 0 && a < INT_MIN / b)) {
        error_flag = 1;
        error_message = "overflow";
        return 0; // won't have any affect. An error will prevent updating value.
    }
    else
        return a*b;
}

int divide(int a, int b) {
    if (b == 0) {
        error_flag = 1;
        error_message = "dividebyzero";
        return 0;
    }
    else if (a==INT_MIN && b==-1) {
        error_flag = 1;
        error_message = "overflow";
        return 0;
    }
    else {
        return a/b;
    }
}

int modulo(int a, int b) {
    int test_divide = divide(a, b);
    if (error_flag == 1)
    {
        return 0;
    }
    else
        return a%b;
}

int echo(int val) {
    if (error_flag == 0) {
        printf("%d\n", val);
    }
    else {
        printf("%s\n", error_message);
        error_flag = 0;
    }
}

void dump() {
    for (int i = 0; i < symbol_num; i++) {
        printf("%c: %d\n", i+'a', symbols[i]);
    }
}

void clear() {
    for (int i = 0; i < symbol_num; i++) {
        symbols[i] = 0;
    }
}

int main() {
    clear();
    yyparse();
    printf("\nCalculator off.\n");
    return 0;
}

void yyerror(char* s) {
    fprintf(stderr, "line %d: %s\n", yylineno, s);
}