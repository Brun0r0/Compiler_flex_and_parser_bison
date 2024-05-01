%{
#include <stdio.h>
#include "parser-bison.tab.h"
%}


%option noyywrap

%%


"cata_esse" { return SCAN; }
"pega_visao" { return PRINT; }

"da_um_confere" { return IF; }
"si_nao" { return ELSE; }

"faz_umas_vez" { return WHILE; }
"repete_um_tanto" { return FOR; }

"mais_maior" { return MAIOR; }
"mais_menor" { return MENOR; }
"mais_maior_ou_ingual" { return MAIORIGUAL; }
"mais_menor_ou_ingual" { return MENORIGUAL; }
"nada_ingual" { return DIFERENTE; }
"eh_ingual" { return IGUAL; }

"*" { return MULT; }
"/" { return DIV; }
"+" { return MAIS; }
"-" { return MENOS; }
"%" { return RESTO; }
"!" { return NEGACAO; }

"(" { return LPAR; }
")" { return RPAR; }
"[" { return RCOL; }
"]" { return LCOL; }
"{" { return RCHAV; }
"}" { return LCHAV; }

"=" { return ATRIB; }
"&" { return AND; }
"|" { return OR; }

"zeh" { return PEV; }

[0-9]+ { return NUM; }
[a-zA-Z][a-zA-Z0-9_]* { return ID; }
" " {}
"\n" {}


%%