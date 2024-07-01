%{
#define TITLE 300
#define SPORT 301
#define YEARS 302
#define NAME 303
#define YEAR_NUM 304
#define COMMA 305
#define HYPHEN 306
#define SINCE 307
#define ALL 308


union {
	char title[20];
  char sport[10];
	char years[8];
	char name[80];
  int yearNum;
  char comma[2];
  char hyphen[5];
  char since[10];
  char all[5];
} yylval;

#include <string.h> 

extern int atoi (const char *);
extern double atof (const char *);
%}

%option noyywrap
%option yylineno

/* exclusive start condition -- deals with C++ style comments */ 
%x COMMENT

%%
"Olympic Sports" {
    strcpy(yylval.title , yytext);
		return TITLE;
}
"<sport>" {
    strcpy(yylval.sport, yytext);
    return SPORT;
}
"<years>" {
    strcpy(yylval.years, yytext);
    return YEARS;
}
\"([A-Z][A-Za-z]*(" "[A-Za-z]*)*)\" {
    strcpy(yylval.name, yytext);
    return NAME;
}
(1((89[6-9])|(9[0-9]{2})))|(20(([0-1][0-9])|(2[0-4]))) {
    yylval.yearNum = atoi (yytext);
    return YEAR_NUM;
}
"," {
    strcpy(yylval.comma, yytext);
    return COMMA;
}
"-"|"to" {
    strcpy(yylval.hyphen, yytext);
    return HYPHEN;
}
"since" {
    strcpy(yylval.since, yytext);
    return SINCE;
}
" all" {
    strcpy(yylval.all, yytext);
    return ALL;
}
"//"     { BEGIN (COMMENT); }
[\n\t ]+  /* skip white space */

<COMMENT>.+ /* skip comment */
<COMMENT>\n {  /* end of comment --> resume normal processing */
                BEGIN (0); }

. {
    fprintf (stderr, "Line number : %d unrecognized token %c \n",yylineno,yytext[0]);
}
%%
int main (int argc, char **argv)
{
  int token;

  if (argc != 2) {
    fprintf(stderr,"Usage: olympics <input file name> %s\n",argv[0]);
    exit (1);
  }

  yyin = fopen (argv[1], "r");
  
  printf("%-20s %-25s\n","Token","Lexeme"); 
  printf("--------------------------------------\n");

  while ((token = yylex ()) != 0)
    switch (token) {
  case TITLE: 
              printf("%-20s %-25s\n","TITLE", yylval.title);
              break;
  case SPORT: 
              printf ("%-20s %-25s\n","SPORT", yylval.sport);
              break;
  case YEARS: 
              printf ("%-20s %-25s\n","YEARS", yylval.years);
              break;
  case NAME: 
              printf ("%-20s %-25s\n","NAME", yylval.name);
              break;
  case YEAR_NUM: 
              printf ("%-20s %-25d\n", "YEAR_NUM", yylval.yearNum);
              break;
  case COMMA: 
              printf ("%-20s %-25s\n","COMMA", yylval.comma);
              break;
  case HYPHEN:
              printf ("%-20s %-25s\n", "HYPHEN", yylval.hyphen);
              break;	  
  case SINCE: 
              printf ("%-20s %-25s\n", "SINCE", yylval.since);
              break;
  case ALL:  
              printf ("%-20s %-25s\n", "ALL", yylval.all);
              break;            	             	              	              
  default:
              fprintf (stderr, "error ... \n"); exit (1);
  } 
  fclose (yyin);
  exit (0);
}