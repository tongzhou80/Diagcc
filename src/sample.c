/* 
 * include four type of errors
 *
 * iint                         -> lexical error
 * unmatched parenthesis        -> syntactic error
 * b undeclared                 -> semantic error 
 * dereference void pointer     -> logical error
 */

iint main() {     
    int a = aa;
    void * c = 0;
    *c = a;
}}
