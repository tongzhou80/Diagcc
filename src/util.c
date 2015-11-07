#include "util.h"

void set_highlight() {
    printf("\033[1m");
}

void set_color(char* color) {
    if (strcmp(color, "red") == 0)
    {
        printf("\033[31m");
    }
    else if (strcmp(color, "purple") == 0)
    {
        printf("\033[35m");
    }
    else if (strcmp(color, "cyan") == 0)
    {
        printf("\033[36m");
    }
    else if (strcmp(color, "green") == 0)
    {
        printf("\033[32m");
    }
    else
    {
        /* other colors */
    }
}

void clear_prop() {
    printf("\033[0m");
}

char* my_concate(char* a, char* b) {
    char* out;
    if((out = (char *)malloc(strlen(a) + strlen(b) + 1)) != NULL)
    {
       strcpy(out, a);
       strcat(out, b);
    }
    else
    {
       printf("fail to allocate enough memory for concated string.\n");
    }
    return out;
}