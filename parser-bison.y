%{
#include <stdio.h>
%}

/* lista de tokens */
%token  PEV SCAN PRINT IF ELSE WHILE FOR MAIOR MENOR MAIORIGUAL MENORIGUAL
        DIFERENTE IGUAL MULT DIV MAIS MENOS RESTO NEGACAO LPAR RPAR RCOL 
        LCOL RCHAV LCHAV ATRIB AND OR NUM ID

%%


programa :      blocos ; 

blocos :        bloco |         /*bloco de códigos*/
                bloco blocos ;

bloco :         linha |         /*linha de código*/
                linha linhas ;
        
linha :         decVar |        /*declarar variavel*/
                atrib |         /*atribuicao*/
                funcao |        /*funções de escrita e leitura*/
                comparacao |


/*declaracao de variaveis*/

declVar :           tipoVar listaVariaveis PEV ; 

tipoVar :           INT ;

listaVariaveis :    var , listaVariaveis |
                    var ;

var :               varId | 
                    varId ATRIB valor ;

varId :             ID |
                    ID LCOL NUM RCOL


/*atribuicao*/

declAtrib :         atribs PEV ;

atribs :            atrib , atribs |
                    atrib ;

atrib :             atribuido ATRIB atribue;

atribuido :         ID |
                    ID LCOL NUM RCOL |
                    ID LCOL ID RCOL ;

atribue :           atribuido |         /*tem tudo que o "atribuido" possui e pode ser um valor tambem*/ 
                    NUM ;







condicao :      IF LPAR conds RPAR PEV

conds :         cond |
                cond AND conds |
                cond OR conds ;

cond :          ID MAIOR  |
                ID MAIORIGUAL  |
                ID MENOR  |
                ID MENORIGUAL  |
                ID IGUAL  |
                ID DIFERENTE  |





funcao :        print |     /*imprimir mensagem*/
                scan ;      /*ler variavel*/






print :         PRINT LPAR string RPAR PEV

scan :          SCAN LPAR ID RPAR PEV

/* Verificar essa parte para colocar um texto e como deve ser as possibilidades de printf*/
string :    text |
            text NUM 



%%

// extern FILE *yyin;                   // (*) descomente para ler de um arquivo

int main(int argc, char *argv[]) {

//    yyin = fopen(argv[1], "r");       // (*)

    yyparse();                          // A função yyparse() inicia o parser

//    fclose(yyin);                     // (*)

    return 0;
}

// A função yyerror() será chamada quando o parser encontrar um erro sintatico
void yyerror(char *s) { fprintf(stderr,"ERRO: %s\n", s); }

/* Lembre-se de excutar primeiro o bison (com -d); depois o flex; depois
 * compilar todo o código:

 $ bison -d parser-bison.y
 $ flex lexico-flex.l
 $ gcc -o compilador lex.yy.c parser-bison.tab.c

 (Pessoal Linux-friendly: considerem escrever um Makefile) */
