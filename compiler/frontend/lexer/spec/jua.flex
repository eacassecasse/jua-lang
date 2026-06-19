package compiler.frontend.lexer.generated;

import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.Symbol;
import compiler.frontend.lexer.tokens.TokenType;
import compiler.frontend.parser.generated.sym;

%%

%class JuaLexer
%public
%unicode
%cup
%line
%column

%xstate COMMENT

%{

private ComplexSymbolFactory symbolFactory;

public JuaLexer(java.io.Reader in, ComplexSymbolFactory sf) {
	this(in);
	this.symbolFactory = sf;
}

private Symbol symbol(TokenType type, int id) {
    return symbol(type, id, yytext());
}

private Symbol symbol(TokenType type, int id, Object value) {
    return symbolFactory.newSymbol(
        type.name(),
        id,
        new ComplexSymbolFactory.Location(yyline + 1, yycolumn + 1),
        new ComplexSymbolFactory.Location(yyline + 1, yycolumn + yylength()),
        value
    );
}

private Symbol eofSymbol() {
	int line = Math.max(1, yyline + 1);
	int column = Math.max(1, yycolumn + 1);

	ComplexSymbolFactory.Location location =
		new ComplexSymbolFactory.Location(line, column);

	return symbolFactory.newSymbol(
		TokenType.EOF.name(),
		sym.EOF,
		location,
		location
	);
}

%}

/* ==========================================================
   Character Classes
   ========================================================== */

DIGIT       = [0-9]

LETTER      = [a-zA-Z_]

IDENTIFIER  = {LETTER}({LETTER}|{DIGIT})*

INTEGER     = {DIGIT}+

NEWLINE     = \n

WHITESPACE  = [ \t\r]+

DOUBLE_STRING = \"([^\"\\]|\\.)*\"

SINGLE_STRING = \'([^\'\\]|\\.)*\'

/* ==========================================================
   Rules
   ========================================================== */

%%

/* ==========================================================
   Whitespace
   ========================================================== */

{WHITESPACE} { }

/* NEWLINE is significant */

{NEWLINE} {
    return symbol(TokenType.NEWLINE, sym.NEWLINE);
}

/* ==========================================================
   Multi-Line Comments
   ========================================================== */

"#*" {
    yybegin(COMMENT);
}

<COMMENT>"*#" {
    yybegin(YYINITIAL);
}

<COMMENT>\n { }

<COMMENT>. { }


/* ==========================================================
   Single-Line Comments
   ========================================================== */

"#"[^\n]* { }

/* ==========================================================
   Keywords
   ========================================================== */

"create"      { return symbol(TokenType.CREATE, sym.CREATE, yytext()); }
"mutable"     { return symbol(TokenType.MUTABLE, sym.MUTABLE, yytext()); }

"function"    { return symbol(TokenType.FUNCTION, sym.FUNCTION, yytext()); }
"return"      { return symbol(TokenType.RETURN, sym.RETURN, yytext()); }

"if"          { return symbol(TokenType.IF, sym.IF, yytext()); }
"else"        { return symbol(TokenType.ELSE, sym.ELSE, yytext()); }

"while"       { return symbol(TokenType.WHILE, sym.WHILE, yytext()); }

"for"         { return symbol(TokenType.FOR, sym.FOR, yytext()); }
"in"          { return symbol(TokenType.IN, sym.IN, yytext()); }

"break"       { return symbol(TokenType.BREAK, sym.BREAK, yytext()); }
"continue"    { return symbol(TokenType.CONTINUE, sym.CONTINUE, yytext()); }

"object"      { return symbol(TokenType.OBJECT, sym.OBJECT, yytext()); }
"trait"       { return symbol(TokenType.TRAIT, sym.TRAIT, yytext()); }
"interface"   { return symbol(TokenType.INTERFACE, sym.INTERFACE, yytext()); }

"uses"        { return symbol(TokenType.USES, sym.USES, yytext()); }

"import"      { return symbol(TokenType.IMPORT, sym.IMPORT, yytext()); }
"export"      { return symbol(TokenType.EXPORT, sym.EXPORT, yytext()); }

"true"        { return symbol(TokenType.TRUE, sym.TRUE, yytext()); }
"false"       { return symbol(TokenType.FALSE, sym.FALSE, yytext()); }
"null"        { return symbol(TokenType.NULL, sym.NULL, yytext()); }

"and"         { return symbol(TokenType.AND, sym.AND, yytext()); }
"or"          { return symbol(TokenType.OR, sym.OR, yytext()); }
"not"         { return symbol(TokenType.NOT, sym.NOT, yytext()); }

"end"         { return symbol(TokenType.END, sym.END, yytext()); }

/* ==========================================================
   Operators
   Longest match first
   ========================================================== */

"=="          { return symbol(TokenType.EQUAL_EQUAL, sym.EQUAL_EQUAL); }
"!="          { return symbol(TokenType.BANG_EQUAL, sym.BANG_EQUAL); }

"<="          { return symbol(TokenType.LESS_EQUAL, sym.LESS_EQUAL); }
">="          { return symbol(TokenType.GREATER_EQUAL, sym.GREATER_EQUAL); }

"="           { return symbol(TokenType.ASSIGN, sym.ASSIGN); }

"<"           { return symbol(TokenType.LESS, sym.LESS); }
">"           { return symbol(TokenType.GREATER, sym.GREATER); }

"+"           { return symbol(TokenType.PLUS, sym.PLUS); }
"-"           { return symbol(TokenType.MINUS, sym.MINUS); }

"*"           { return symbol(TokenType.STAR, sym.STAR); }
"/"           { return symbol(TokenType.SLASH, sym.SLASH); }

"%"           { return symbol(TokenType.PERCENT, sym.PERCENT); }

/* ==========================================================
   Delimiters
   ========================================================== */

"("           { return symbol(TokenType.LEFT_PAREN, sym.LEFT_PAREN); }
")"           { return symbol(TokenType.RIGHT_PAREN, sym.RIGHT_PAREN); }

"["           { return symbol(TokenType.LEFT_BRACKET, sym.LEFT_BRACKET); }
"]"           { return symbol(TokenType.RIGHT_BRACKET, sym.RIGHT_BRACKET); }

","           { return symbol(TokenType.COMMA, sym.COMMA); }
":"           { return symbol(TokenType.COLON, sym.COLON); }
"."           { return symbol(TokenType.DOT, sym.DOT); }

/* ==========================================================
   String Literals
   ========================================================== */

{DOUBLE_STRING} {
    return symbol(TokenType.STRING_LITERAL, sym.STRING_LITERAL, yytext());
}

{SINGLE_STRING} {
    return symbol(TokenType.STRING_LITERAL, sym.STRING_LITERAL, yytext());
}

/* ==========================================================
   Numeric Literals
   ========================================================== */

{INTEGER} {
    return symbol(TokenType.INTEGER_LITERAL, sym.INTEGER_LITERAL, Integer.parseInt(yytext()));
}

/* ==========================================================
   Identifiers
   ========================================================== */

{IDENTIFIER} {
    return symbol(TokenType.IDENTIFIER, sym.IDENTIFIER, yytext());
}

/* ==========================================================
   EOF
   ========================================================== */

<COMMENT><<EOF>> {
	throw new RuntimeException(
		"Unterminated multi-line comment."
	);
}
<<EOF>> {
    return eofSymbol();
}

/* ==========================================================
   Invalid Characters
   ========================================================== */

. {
    throw new RuntimeException(
        "Unexpected character '" +
        yytext() +
        "' at line " +
        (yyline + 1) +
        ", column " +
        (yycolumn + 1)
    );
}
