
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

DOPPIAMAIUSCOLA = ([A-Z]{2})[a-z]*
DUEPUNTI_MINUSCOLE = ([:]+)[a-z]*
MATRICOLA = [8569]+

%%

"("                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.OPEN_PAREN; }
")"                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.CLOSE_PAREN; }
"["					  { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.OPEN_QUADRA; }
"]"					  { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.CLOSE_QUADRA; }
[a-z]+ | {DOPPIAMAIUSCOLA} |
{DUEPUNTI_MINUSCOLE} | {MATRICOLA}		{ yyparser.yylval = new ParserVal(yytext());
												return Parser.SKIP; }

[^] {} /*butta il resto*/
