%{
#include <stdio.h>
#include <stdlib.h>
%}

%token NULL_VALUE
%token DOT
%token COMMA
%token LP
%token RP
%token LCB
%token RCB
%token SEMICOLON
%token ASSIGN_OP
%token ADD
%token SUBTRACT
%token MULTIPLY
%token DIVIDE
%token MODULO
%token GREATER
%token LESS
%token LESS_EQUAL
%token GREATER_EQUAL
%token POWER
%token NEWLINE
%token EQUALS
%token AND
%token OR
%token NOT
%token XOR
%token NAND
%token NOR
%token BOOLEAN_VALUE
%token START_PROGRAM
%token END_PROGRAM
%token PRIMITIVE
%token FUNCTION_DECLARATION
%token END_DECLARATION
%token READ_TEMPERATURE
%token READ_HUMIDITY
%token READ_AIR_QUALITY
%token READ_AIR_PRESSURE
%token READ_LIGHT
%token READ_SOUND_LEVEL
%token READ_TIMESTAMP
%token SET_SWITCH_AS
%token INTEGER
%token REAL
%token STRING
%token CHAR
%token BOOLEAN
%token DATE
%token TIME
%token DATETIME
%token CONNECTION
%token VOID
%token CONNECT_TO_URL
%token DISCONNECT
%token FETCH_INTEGER
%token SEND_INTEGER
%token IF
%token END_IF
%token ELSE
%token ELSE_IF
%token FOR
%token END_FOR
%token WHILE
%token END_WHILE
%token INPUT
%token OUTPUT
%token RETURN
%token INTEGER_VALUE
%token REAL_VALUE
%token CHAR_VALUE
%token STRING_VALUE
%token COMMENT
%token DATE_VALUE
%token TIME_VALUE
%token DATETIME_VALUE
%token IDENTIFIER
%token CONSTANT_IDENTIFIER
%token UNDERSCORE

%start start
%%
start:		
		      START_PROGRAM NEWLINE statement_list END_PROGRAM {printf("\rInput Program is valid.\n");return 1;};
	
statement_list: 
		      statement 
	      | statement_list statement	
			
statement: 	
		      expression NEWLINE 
	      | initialization NEWLINE 
	      | iteration NEWLINE 
	      | if_statement NEWLINE 
	      | function_declaration NEWLINE 	 
	      | function_call NEWLINE 
	      | comment NEWLINE 
	      | return_statement NEWLINE 
	      | statement_with_comment NEWLINE 
	      | NEWLINE 	




function_call:	
	      	primitive_function_call
        | non_primitive_function_call
        | input_function_call
        | output_function_call
        | connection_function_call
				
primitive_function_call:	
          PRIMITIVE DOT READ_TEMPERATURE LP RP
        | PRIMITIVE DOT READ_HUMIDITY LP RP
        | PRIMITIVE DOT READ_AIR_QUALITY LP RP
        | PRIMITIVE DOT READ_AIR_PRESSURE LP RP
        | PRIMITIVE DOT READ_LIGHT LP RP
        | PRIMITIVE DOT READ_SOUND_LEVEL LP RP
        | PRIMITIVE DOT READ_TIMESTAMP LP RP
        | PRIMITIVE DOT SET_SWITCH_AS LP INTEGER_VALUE COMMA BOOLEAN_VALUE RP
					
non_primitive_function_call:  	
          IDENTIFIER LP RP
        | IDENTIFIER LP argument_list RP
					
argument_list:			
          data
        | data COMMA argument_list
					
input_function_call:		
	      	INPUT LP IDENTIFIER RP
				
output_function_call:		
		      OUTPUT LP data RP
				
connection_function_call:	
		        IDENTIFIER DOT CONNECT_TO_URL LP STRING_VALUE RP
          | IDENTIFIER DOT CONNECT_TO_URL LP IDENTIFIER RP
          | IDENTIFIER DOT DISCONNECT LP RP
          | IDENTIFIER DOT SEND_INTEGER LP data RP
          | IDENTIFIER DOT FETCH_INTEGER LP RP
								
data:				
				    INTEGER_VALUE
          | REAL_VALUE
          | CHAR_VALUE
          | STRING_VALUE
          | DATE_VALUE
          | TIME_VALUE
          | DATETIME_VALUE
          | BOOLEAN_VALUE
          | entity
          | function_call
				  | NULL_VALUE
					
entity:		
            IDENTIFIER
	        | CONSTANT_IDENTIFIER
			

initialization:		
		        default_initialization 
          | assignment_initialization
		      | constant_initialization
				
				
default_initialization:			
	        datatype IDENTIFIER
	
assignment_initialization:		
          datatype IDENTIFIER ASSIGN_OP data
          | datatype IDENTIFIER ASSIGN_OP arithmetic_expression
	
constant_initialization:		
	          datatype CONSTANT_IDENTIFIER ASSIGN_OP data
          | datatype CONSTANT_IDENTIFIER ASSIGN_OP arithmetic_expression
	
datatype:		
            STRING
		      | INTEGER
		      | REAL
		      | CHAR
		      | DATE
		      | BOOLEAN
		      | TIME
		      | DATETIME
		      | CONNECTION
				

conditional_op:
            GREATER 
          | LESS
          | LESS_EQUAL 
          | GREATER_EQUAL 
          | EQUALS 
          | AND
          | OR 
          | NOT
          | XOR 
          | NAND
          | NOR
	

//-------- Conditional Statements -------- 

if_statement:
            if_condition statement_list END_IF 
          | open_if_statement ELSE NEWLINE statement_list END_IF
	
open_if_statement:
          if_condition statement_list 
          | open_if_statement elif_condition statement_list
	
if_condition: 
          IF LP boolean_expression RP NEWLINE

elif_condition: 
          ELSE_IF LP boolean_expression RP NEWLINE


//-------- Loops -------- 


iteration: 
            for_loop 
          | while_loop
	
for_loop:
	        FOR LP assignment_initialization COMMA boolean_expression COMMA assignment_expression RP NEWLINE statement_list END_FOR
	
while_loop:
          WHILE LP boolean_expression RP NEWLINE statement_list END_WHILE
          | WHILE LP IDENTIFIER RP NEWLINE statement_list END_WHILE
	

//-------- Expression -------- 

expression:
            boolean_expression 
          | assignment_expression
          | arithmetic_expression
	
boolean_expression:
            data conditional_op data 
          | BOOLEAN
          | LP boolean_expression RP conditional_op data 
          | data conditional_op LP boolean_expression RP
          | LP boolean_expression RP conditional_op LP boolean_expression RP
	
assignment_expression:
          IDENTIFIER ASSIGN_OP arithmetic_expression 
          | IDENTIFIER ASSIGN_OP boolean_expression
          | IDENTIFIER ASSIGN_OP data 
	
arithmetic_expression:
            addition 
          | subtraction 
          | multiplication 
          | division 
          | power 
          | modulo
	

//-------- Arithmetic Operations -------- 

computable:
            INTEGER_VALUE
          | REAL_VALUE 
          | entity
          | function_call 

addition:
            computable ADD computable 
          | computable ADD LP arithmetic_expression RP
          | LP arithmetic_expression RP ADD computable 
          | LP arithmetic_expression RP ADD LP arithmetic_expression RP 
          | STRING_VALUE ADD STRING_VALUE 
          | computable ADD addition  
	
subtraction:
          computable SUBTRACT computable 
          | LP arithmetic_expression RP SUBTRACT computable 
          | LP arithmetic_expression RP SUBTRACT LP arithmetic_expression RP 
          | computable SUBTRACT LP arithmetic_expression RP
          | subtraction SUBTRACT computable
	
multiplication:
            computable MULTIPLY computable
          | computable MULTIPLY LP arithmetic_expression RP
          | LP arithmetic_expression RP MULTIPLY computable 
            | LP arithmetic_expression RP  MULTIPLY LP arithmetic_expression RP 
          | computable MULTIPLY multiplication   
	
division:
            computable DIVIDE computable 
          | computable DIVIDE LP arithmetic_expression RP  
          | LP arithmetic_expression RP DIVIDE computable 
          | LP arithmetic_expression RP DIVIDE LP arithmetic_expression RP   
	

power:
            computable POWER computable  
          | computable POWER LP arithmetic_expression RP  
          | LP arithmetic_expression RP POWER computable 
          | LP arithmetic_expression RP POWER LP arithmetic_expression RP  
	

modulo:
            computable MODULO computable 
          | computable MODULO LP arithmetic_expression RP  
          | LP arithmetic_expression RP MODULO computable 
          | LP arithmetic_expression RP MODULO LP arithmetic_expression RP
	
function_declaration: 	
            FUNCTION_DECLARATION return_type IDENTIFIER LP RP NEWLINE statement_list return_statement NEWLINE END_DECLARATION
          | FUNCTION_DECLARATION return_type IDENTIFIER LP parameter_list RP NEWLINE statement_list return_statement NEWLINE END_DECLARATION

parameter_list:		
            datatype IDENTIFIER
          | datatype IDENTIFIER COMMA parameter_list

return_type:		
            datatype
          | VOID
					
return_statement: 
            RETURN data 

comment: 
            COMMENT

statement_with_comment: 	
		      expression COMMENT
	      | initialization COMMENT
	      | iteration COMMENT
	      | if_statement COMMENT
	      | function_declaration COMMENT
	      | function_call COMMENT
	      | return_statement COMMENT
        
%%

#include "lex.yy.c"
int yylineno;
int yydebug=1;

int main() {
	return yyparse();
}

int yyerror( char *s ) { 
	fprintf(stderr,"Syntax error on line: %d!\n",yylineno);
	return 1;
}
