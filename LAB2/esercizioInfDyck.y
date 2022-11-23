%{
  import java.io.*;
%}

%token OPEN_PAREN;
%token CLOSE_PAREN;
%token OPEN_QUADRA;
%token CLOSE_QUADRA;
%token <sval> SKIP;
%token <sval> SKIP1;
%token <sval> SKIP2;
%token <sval> SKIP_DOPPIA_MAIUSCOLA;

%start s

%%

parens  : OPEN_PAREN s CLOSE_PAREN
        | OPEN_PAREN CLOSE_PAREN

quadre 	: OPEN_QUADRA s CLOSE_QUADRA
		| OPEN_QUADRA CLOSE_QUADRA

exp     : parens
		| quadre

exps    : exp SKIP 	{ 
						System.out.println("txt: " + $2); 
					}
		| exp SKIP1 {
						String stringa = $2;
						int ultimoIndice = stringa.lastIndexOf(':');
						String daStampare = "";
						if(ultimoIndice >= 0 && ultimoIndice < stringa.length()-1){
							daStampare = stringa.substring(ultimoIndice+1);
						}
						System.out.println("txt: " + daStampare);
					}
		| exp SKIP2 {
						String stringa = $2;
						int ultimoIndice = stringa.lastIndexOf(':');
						System.out.println("txt: " + stringa.substring(ultimoIndice));
					}		
		| exp SKIP_DOPPIA_MAIUSCOLA
					{
						
						String stringa = $2;
						
						if(stringa.charAt(0) != stringa.charAt(1)){
							
							if(stringa.length() > 2)
								System.out.println("Err. " + stringa.substring(2));
							else
								System.out.println("Err.");
						}
						else{
							if(stringa.length() > 2)
								System.out.println(stringa.substring(2));
						}
					}
        | exp

s       : SKIP 		{ 
						System.out.println("txt: " + $1); 
					}
		| SKIP1 	{
						String stringa = $1;
						int ultimoIndice = stringa.lastIndexOf(':');
						String daStampare = "";
						if(ultimoIndice >= 0 && ultimoIndice < stringa.length()-1){
							daStampare = stringa.substring(ultimoIndice+1);
						}
						System.out.println("txt: " + daStampare);
					}
		| SKIP2 	{
						String stringa = $1;
						int ultimoIndice = stringa.lastIndexOf(':');
						System.out.println("txt " + stringa.substring(ultimoIndice));
					}
		| SKIP_DOPPIA_MAIUSCOLA
					{
						
						String stringa = $1;
						if(stringa.charAt(0) != stringa.charAt(1)){
							
							if(stringa.length() > 2)
								System.out.println("Err. " + stringa.substring(2));
							else
								System.out.println("Err.");
						}
						else{
							
							if(stringa.length() > 2)
								System.out.println(stringa.substring(2));
						}
					}
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
