
%%

%byaccj

%{
  /* store a reference to the parser object */
  private Parser yyparser;

  /* constructor taking an additional parser object */
  public Yylex(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }
%}

DUEPUNTI_PARI_MINUSCOLE = (([:]{2})+)([a-z]+)
DUEPUNTI_DISPARI_MINUSCOLE = (([:]{2})+)[:]([a-z]+)
DOPPIA_MAIUSCOLA = ([A-Z]{2})[a-z8569]*
MATRICOLA = [8569]+

%%

"("                   			{ 	
									yyparser.yylval = new ParserVal(""+yycharat(0));
									return Parser.OPEN_PAREN; 
								}
")"                   			{ 
									yyparser.yylval = new ParserVal(""+yycharat(0));
									return Parser.CLOSE_PAREN; 
								}
"["					  			{ 
									yyparser.yylval = new ParserVal(""+yycharat(0));
									return Parser.OPEN_QUADRA; 
								}
"]"					  			{ 
									yyparser.yylval = new ParserVal(""+yycharat(0));
									return Parser.CLOSE_QUADRA; 
								}
[a-z]+ | {MATRICOLA}			{ 
									yyparser.yylval = new ParserVal(yytext());
									return Parser.SKIP; 
								}
{DUEPUNTI_PARI_MINUSCOLE}		{ 
									yyparser.yylval = new ParserVal(yytext());
									return Parser.SKIP1; 
								}
{DUEPUNTI_DISPARI_MINUSCOLE}	{ 
									yyparser.yylval = new ParserVal(yytext());
									return Parser.SKIP2; 
								}
{DOPPIA_MAIUSCOLA}				{
									yyparser.yylval = new ParserVal(yytext());
									return Parser.SKIP_DOPPIA_MAIUSCOLA; 
								}


[^] 							{
								} /*butta il resto*/
