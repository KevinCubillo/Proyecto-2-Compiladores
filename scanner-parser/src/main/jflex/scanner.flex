package com.compiladores;

import java_cup.runtime.*;

%%
%public
%class Lexer
%cup


%{
    StringBuffer string = new StringBuffer();

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}


Integer = 0|[1-9][0-9]*
Float = {Integer}(\.[0-9]*)?
Boolean = true | false
String = \"(\\.|[^\"])*\"
Char = '[^']'
Identifier = [:jletter:] [:jletterdigit:]*


LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent = ( [^*] | \*+ [^/*] )*


%%
// Operators
"+" { return symbol(sym.PLUS, yytext()); }
"-" { return symbol(sym.MINUS, yytext()); }
"*" { return symbol(sym.TIMES, yytext()); }
"/" { return symbol(sym.DIVIDE, yytext()); }
"%" { return symbol(sym.MODULE, yytext()); }
"^" { return symbol(sym.POWER, yytext()); }
"(" { return symbol(sym.LPAREN, yytext()); }
")" { return symbol(sym.RPAREN, yytext()); }
"++" { return symbol(sym.INCREMENT, yytext()); }
"--" { return symbol(sym.DECREMENT, yytext()); }
"=" { return symbol(sym.ASSIGN, yytext()); }
";" { return symbol(sym.ENDLINE, yytext()); }
"==" { return symbol(sym.EQUALS, yytext()); }
"!=" { return symbol(sym.DIFFERENT, yytext()); }
">" { return symbol(sym.GREATER, yytext()); }
"<" { return symbol(sym.LESS, yytext()); }
">=" { return symbol(sym.GREATEREQUAL, yytext()); }
"<=" { return symbol(sym.LESSEQUAL, yytext()); }
"&&" { return symbol(sym.AND, yytext()); }
"||" { return symbol(sym.OR, yytext()); }
"!" { return symbol(sym.NOT, yytext()); }

// Delimiters
"{" { return symbol(sym.BLOCKSTART, yytext()); }
"}" { return symbol(sym.BLOCKEND, yytext()); }
"," { return symbol(sym.COMMA, yytext()); }
"#" { return symbol(sym.SEPARATOR, yytext()); }
"if" { return symbol(sym.IF, yytext()); }

// Keywords
"else" { return symbol(sym.ELSE, yytext()); }
"return" { return symbol(sym.RETURN, yytext()); }
"break" { return symbol(sym.BREAK, yytext()); }
"for" { return symbol(sym.FOR, yytext()); }
"in" { return symbol(sym.IN, yytext()); }
"range" { return symbol(sym.RANGE, yytext()); }
"while" { return symbol(sym.WHILE, yytext()); }
"switch"  { return symbol(sym.SWITCH, yytext()); }
"case" { return symbol(sym.CASE, yytext()); }
":" { return symbol(sym.DOTS, yytext()); }
"default" { return symbol(sym.DEFAULT, yytext()); }
"read" { return symbol(sym.READ, yytext()); }
">>" { return symbol(sym.READSYMBOL, yytext()); }
"print" { return symbol(sym.PRINT, yytext()); }
"<<" { return symbol(sym.PRINTSYMBOL, yytext()); }
"int" { return symbol(sym.INTEGERTYPE, yytext()); }
"float" { return symbol(sym.FLOATTYPE, yytext()); }
"bool" { return symbol(sym.BOOLEANTYPE, yytext()); }
"char" { return symbol(sym.CHARTYPE, yytext()); }
"string" { return symbol(sym.STRINGTYPE, yytext()); }

// Literals
{Integer}+ { return symbol(sym.INTEGER, Integer.valueOf(yytext())); }
{Float}+ { return symbol(sym.FLOAT, Float.valueOf(yytext())); }
{Boolean}+ { return symbol(sym.BOOLEAN, Boolean.valueOf(yytext())); }
{String}+ { return symbol(sym.STRING, yytext()); }
{Char}+ { return symbol(sym.CHAR, yytext()); }
{Identifier}+ { return symbol(sym.IDENTIFIER, yytext()); }

{Comment}+ { /* ignore */}
{WhiteSpace}+ { /* ignore */ }


// Caracter no valido
[^] { return symbol(sym.ERROR_RECOVERY, yytext()); }


