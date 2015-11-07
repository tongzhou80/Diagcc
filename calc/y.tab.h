/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     number = 258,
     identifier = 259,
     dump_command = 260,
     clear_command = 261,
     left_shift = 262,
     right_shift = 263,
     assign_sum = 264,
     assign_diff = 265,
     assign_pro = 266,
     assign_quo = 267,
     assign_rem = 268,
     assign_left_shift = 269,
     assign_right_shift = 270,
     assign_bit_and = 271,
     assign_bit_xor = 272,
     assign_bit_or = 273
   };
#endif
/* Tokens.  */
#define number 258
#define identifier 259
#define dump_command 260
#define clear_command 261
#define left_shift 262
#define right_shift 263
#define assign_sum 264
#define assign_diff 265
#define assign_pro 266
#define assign_quo 267
#define assign_rem 268
#define assign_left_shift 269
#define assign_right_shift 270
#define assign_bit_and 271
#define assign_bit_xor 272
#define assign_bit_or 273




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 26 "calc.y"
{long long num; char id; char* str;}
/* Line 1529 of yacc.c.  */
#line 87 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

