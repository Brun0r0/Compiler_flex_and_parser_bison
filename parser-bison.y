%{
#include <stdio.h>

int contl = 1;
%}

%union {
    char *texto;
    char *id_nome;
    int valor_int
}


/* lista de tokens */
%token  INT 
        SCAN PRINT 
        IF ELSE 
        WHILE FOR 
        AND OR 
        MAIOR MENOR MAIORIGUAL MENORIGUAL DIFERENTE IGUAL NAO
        MULT DIV MAIS MAISMAIS MENOS MENOSMENOS RESTO ATRIB
        LPAR RPAR RCOL LCOL RCHAV LCHAV 
        <valor_int>NUM <id_nome>ID <texto>TEXTO 
        PEV VIRGULA
        

%%

programa :          blocos ; 

blocos :            bloco |         /*bloco de códigos*/
                    bloco blocos ;

bloco :             LCHAV linhas RCHAV ;

linhas :            linha |         /*linha de código*/
                    linha linhas ; 
        
linha :             declVar PEV |        /*declarar variavel*/
                    atrib PEV |         /*atribuicao*/
                    selecao |
                    laco |
                    funcao PEV ;


/*declaracao de variaveis*/

declVar :           INT listaVariaveis ; 

listaVariaveis :    var |
                    var VIRGULA listaVariaveis ;

var :               varId | 
                    varId ATRIB expr ;

varId :             ID |
                    ID LCOL NUM RCOL ;


/*atribuicao*/

atrib :             ID ATRIB expr |
                    ID LCOL expr RCOL ATRIB expr ;

expr :              expr MAIS termo |
                    expr MENOS termo |
                    termo ;

termo :             termo DIV fator | 
                    termo MULT fator | 
                    termo RESTO fator |
                    fator ;

fator :             ID | 
                    NUM |
                    ID LCOL NUM RCOL |
                    ID LCOL ID RCOL |
                    LPAR expr RPAR ;

/*selecao*/

selecao :           IF LPAR listCond RPAR bloco |
                    IF LPAR listCond RPAR bloco selecao2 ;

selecao2 :          ELSE IF LPAR listCond RPAR bloco |
                    ELSE IF LPAR listCond RPAR bloco selecao2 |
                    ELSE bloco ;

listCond :          comp |
                    comp AND listCond |
                    comp OR listCond ;

comp :              expr simbComp expr |
                    NAO LPAR listCond RPAR ;
                    
simbComp :          MAIOR |
                    MENOR |
                    MAIORIGUAL |
                    MENORIGUAL |
                    DIFERENTE |
                    IGUAL ;

laco :              while |
                    for ;

while :             WHILE LPAR listCond RPAR bloco;

for :               FOR LPAR INT var VIRGULA comp VIRGULA expr RPAR bloco |
                    FOR LPAR var VIRGULA comp VIRGULA expr RPAR bloco |

funcao :            scan |
                    printf ;
                    
scan :              SCAN LPAR varId RPAR |
                    SCAN LPAR ID LCOL ID RCOL RPAR;

printf :            PRINT LPAR text RPAR ;

text :              TEXTO |
                    TEXTO VIRGULA text |
                    ID |
                    ID VIRGULA text |
                    ID LCOL NUM RCOL |
                    ID LCOL NUM RCOL VIRGULA text |
                    ID LCOL ID RCOL |
                    ID LCOL ID RCOL VIRGULA text ;
                
%%

extern FILE *yyin;

int main(int argc, char *argv[]) {

    yyin = fopen("programa.txt", "r");

    yyparse();

    fclose(yyin);

    return 0;
}

void yyerror(char *s) { fprintf(stderr,"Sintax Error\n"); }

/*

 * compilar todo o código:

 $ bison -d parser-bison.y
 $ flex flex.l
 $ gcc -o compilador lex.yy.c parser-bison.tab.c

 (Pessoal Linux-friendly: considerem escrever um Makefile) */
