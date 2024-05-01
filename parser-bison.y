%{
#include <stdio.h>
%}

%union {
    char *str_val;
    int int_val;
}

/* lista de tokens */
%token  INT PEV SCAN PRINT IF ELSE WHILE FOR MAIOR MENOR MAIORIGUAL MENORIGUAL
        DIFERENTE IGUAL MULT DIV MAIS MENOS RESTO NAO LPAR RPAR RCOL 
        LCOL RCHAV LCHAV ATRIB AND OR <int_val>NUM <str_val>ID VIRGULA

%define parse.error verbose

%%


programa :      blocos ; 

blocos :        bloco |         /*bloco de códigos*/
                bloco blocos ;

bloco :         LCHAV linhas RCHAV ;

linhas :        linha |         /*linha de código*/
                linha linhas ; 
        
linha :         declVar |        /*declarar variavel*/
                atrib |         /*atribuicao*/
                condicao |
                funcao ;        /*funções de escrita e leitura*/
                

/*declaracao de variaveis*/

declVar :           INT listaVariaveis PEV ; 

listaVariaveis :    var |
                    var VIRGULA listaVariaveis ;

var :               varId | 
                    varId ATRIB NUM ;

varId :             ID |
                    ID LCOL NUM RCOL ;


/*atribuicao*/

atrib :             ID ATRIB expr PEV ;

expr :              expr MAIS termo |
                    expr MENOS termo |
                    termo ;

termo :             termo DIV fator | 
                    termo MULT fator | 
                    termo RESTO fator |
                    fator ;

fator :             ID | 
                    NUM | 
                    LPAR expr RPAR ;

/*comparacao*/

condicao :          IF LPAR comparacoes RPAR ;

comparacoes:        comparacao |
                    comparacao AND comparacoes |
                    comparacao OR comparacoes ;


comparacao :        expr comparar expr |
                    NAO LPAR expr comparar expr RPAR ;

comparar :          MAIOR |
                    MENOR |
                    MAIORIGUAL |
                    MENORIGUAL |
                    DIFERENTE |
                    IGUAL ;






/*funcoes escrever e ler*/



funcao :             /*imprimir mensagem*/
                scan ;      /*ler variavel*/


scan :          SCAN LPAR ID RPAR PEV ;



condicao :      IF LPAR conds RPAR PEV ;

conds :         cond |
                cond AND conds |
                cond OR conds ;

cond :          ID MAIOR  |
                ID MAIORIGUAL  |
                ID MENOR  |
                ID MENORIGUAL  |
                ID IGUAL  |
                ID DIFERENTE  ;






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
 $ flex flex.l
 $ gcc -o compilador lex.yy.c parser-bison.tab.c

 (Pessoal Linux-friendly: considerem escrever um Makefile) */
