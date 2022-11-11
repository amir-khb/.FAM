%option main
startProgram	STARTPROGRAM
endprogram		ENDPROGRAM
prim_func_call	PRIM
prim_func		read_temp|read_hum|read_air_qual|read_air_press|read_light|read_sound_lvl|read_timestamp|set_switch_as
conditional_op	EQUALS|AND|OR|NOT|XOR|NAND|NOR
fun_dec			FUNC
return_stmt		RETURN
end_func		ENDFUNC
assign			=
newline 		\n
null_type		NULL
int_type		Integer
char_type		Char
string_type		String
real_type 		Real
boolean_type	TrueOrFalse
date_type 		Date
time_type 		Time
connection_type	Connection
connection_func	connect_to_url|disconnect|fetch_integer|send_integer
datetime_type 	DateTime
void_type		Void
if_stmt 		IF
else_stmt 		ELSE
elseif_stmt 	ELSEIF
endif			ENDIF
for_stmt		FOR
endfor_stmt		ENDFOR
while_stmt		WHILE
endwhile_stmt	ENDWHILE
input			input
output			output
true			TRUE
false			FALSE
digit			[0-9]
lower_case_let	[a-z]
upper_case_let	[A-Z]
letter			{upper_case_let}|{lower_case_let}
underscore		\_
identifier		{letter}({letter}|{digit}|{underscore})*
constant		{underscore}{identifier}
func_call		{identifier}()
string_stmt 	\"(.)*\"
bool_stmt		{true}|{false}
int_stmt		[-]?{digit}+
real_stmt 		[-]?{digit}*(\.)?{digit}+
char_stmt		\'{letter}\'
date_stmt		{digit}{digit}-{digit}{digit}-{digit}{digit}{digit}{digit}
time_stmt		{digit}{digit}:{digit}{digit}:{digit}{digit}
datetime_stmt	{date_stmt}\ {time_stmt}
comment			#([^#])*#

%%
{null_type}			printf("NULL_VALUE ");
\!					printf("NOT ");
\.					printf("DOT ");
\,            		printf("COMMA ");
\(            		printf("LP ");
\)            		printf("RP ");
\{            		printf("LCB ");
\}            		printf("RCB ");
\;            		printf("SEMICOLON ");
\=            		printf("ASSIGN_OP ");
\+        			printf("ADD ");
\-        			printf("SUBTRACT ");
\*					printf("MULTIPLY ");
\/					printf("DIVIDE ");
\%					printf("MODULO ");
\>					printf("GREATER ");
\<					printf("LESS ");
\<=					printf("LESS_EQUAL ");
\>=					printf("GREATER_EQUAL ");
\^					printf("POWER");
{conditional_op}	printf(" %s ", yytext);
{startProgram}		printf("START_PROGRAM ");
{endprogram}		printf("END_PROGRAM ");
{prim_func_call}	printf("PRIMITIVE_FUNCTION_CALL ");
{prim_func}			printf(" %s ", yytext);
{fun_dec}			printf("FUNCTION_DECLARATION ");
{end_func}			printf("END_FUNCTION_DECLARATION ");
{newline}			printf("NEW_LINE \n");
{int_type}			printf("INTEGER ");
{real_type}			printf("REAL ");
{string_type}		printf("STRING ");
{char_type}			printf("CHAR ");
{boolean_type}		printf("BOOLEAN ");
{date_type} 		printf("DATE ");
{time_type} 		printf("TIME ");
{datetime_type} 	printf("DATETIME ");
{connection_type}	printf("CONNECTION ");
{connection_func}	printf(" %s ", yytext);
{if_stmt}			printf("IF ");
{endif}				printf("END_IF ");
{else_stmt}			printf("ELSE ");
{elseif_stmt}		printf("ELSE_IF ");
{for_stmt}			printf("FOR ");
{endfor_stmt}		printf("END_FOR ");
{while_stmt}		printf("WHILE ");
{endwhile_stmt}		printf("END_WHILE ");
{true}				printf("TRUE ");
{false}				printf("FALSE ");
{input}				printf("INPUT ");
{output}			printf("OUTPUT ");
{void_type}			printf("VOID ");
{constant}			printf("CONSTANT ");
{int_stmt}			printf("INTEGER_VALUE ");
{real_stmt} 		printf("REAL_VALUE ");
{char_stmt}			printf("CHAR_VALUE ");
{string_stmt} 		printf("STRING_VALUE ");
{comment}			printf("COMMENT ");
{return_stmt}		printf("RETURN_TYPE");
{date_stmt}			printf("DATE_VALUE ");
{time_stmt}			printf("TIME_VALUE ");
{datetime_stmt}		printf("DATETIME_VALUE ");
{identifier}		printf("IDENTIFIER ");

