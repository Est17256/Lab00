grammar Decaf;
id
	:	Letter (Letter|Digit)*	;
num
	:	Digit+	;
Digit 
	:	[0-9]	;
Letter
	:	[a-zA-Z]	;
program 
	:	'class' id '{' (declaration)* '}'	;
declaration 
	:   structDeclaration
	|   varDeclaration
	|   methodDeclaration	; 
varDeclaration 
	:	varType id ';'	|	varType  id '[' num ']' ';'	;
structDeclaration
	:   'struct' id '{' (varDeclaration)* '}'	;
	// :   'struct' id '{' (varDeclaration)* '}' (';')?	;
varType
	:   'int'														
	|   'char'														
	|   'boolean'													
	|   'struct' id												
	|   structDeclaration											
	|   'void'	;
methodDeclaration
	:	methodType id '(' (parameter)* ')' block	;
methodType
	:   'int'														
	|   'char'														
	|   'boolean'																																	
    |   'void'	;
parameter
	:	parameterType id   |    parameterType id '[' ']'	;
	// :	parameterType id   |    parameterType id '[' ']'	|	'void'	;
parameterType
	:   'int'
	|   'char'
	|   'boolean'	;
block
	:   '{'(varDeclaration)* (statement)* '}'	;
statement
   	:   'if' '(' expression ')' block ('else' block)?
	|   'while' '(' expression ')' block
	|   'return' (expression)? ';'	
	|   methodCall 	';'										
	|   block														
	|   location '=' expression';'												
	|   (expression)? ';'	;
location  
	:	id ('.' location)? | id '[' expression ']' ('.' location)?    ;
expression
	:   location										
	|   methodCall											
	|   literal	
	|	expression op expression								
	|   '-' expression
	|   '!' expression
	|   '(' expression ')'	;
methodCall
	:	id '(' (arg)* ')'	;
arg
	:   expression    ;
op
	:	arith_op   |	rel_op	|	eq_op	|	cond_op	;
arith_op
    :	'*'		|	 '/'	|	'%' |	'+'		|	'-'		;
rel_op
	:	'<'		|	 '>' 	| 	'<=' 	|	 '>=' 	;
eq_op
	: 	'=='	 |	 '!='	 ;
cond_op
	:	'&&'	|	'||'	;
literal
	:	int_literal    |    char_literal	|	bool_literal	;
int_literal
	:	num		;
char_literal
	:	'\'' Letter '\'' 	;
bool_literal 
	:	'true'	|	'false'		;
SPACE
    :	[ \t\r\n\u000C]+ -> skip	;