%{
  import java.io.*;
%}

%token OPEN_PAREN;
%token CLOSE_PAREN;
%token OPEN_QUADRA;
%token CLOSE_QUADRA;
%token <sval> SKIP;

%start s

%%

parens  : OPEN_PAREN s CLOSE_PAREN
        | OPEN_PAREN CLOSE_PAREN

quadre 	: OPEN_QUADRA s CLOSE_QUADRA
		| OPEN_QUADRA CLOSE_QUADRA

exp     : parens
		| quadre

exps    : exp SKIP {}
        | exp

s       : SKIP {}
        | exps
        | s exps

%%

void yyerror(String s)
{
 System.out.println("err:"+s);
 System.out.println("   :"+yylval.sval);
}

static Yylex lexer;
int yylex()
{
 try {
  return lexer.yylex();
 }
 catch (IOException e) {
  System.err.println("IO error :"+e);
  return -1;
 }
}

public static void main(String args[])
{
 System.out.println("[Quit with CTRL-D]");
 Parser par = new Parser();
 lexer = new Yylex(new InputStreamReader(System.in), par);
 par.yyparse();
}
