lower_case_let	[a-z]
upper_case_let	[A-Z]
digit			[0-9]
letter			{upper_case_let}|{lower_case_let}
underscore		\_
identifier		{letter}({letter}|{digit}|{underscore})*
constant		{underscore}{identifier}
string_val 		\"(.)*\"
bool_val		TRUE|FALSE
int_val			[-]?{digit}+
real_val 		[-]?{digit}*(\.)?{digit}+
char_val		\'{letter}\'
date_val		{digit}{digit}-{digit}{digit}-{digit}{digit}{digit}{digit}
time_val		{digit}{digit}:{digit}{digit}:{digit}{digit}
datetime_val	{date_val}[ \t]{time_val}
comment			#([^#])*#
null_type		NULL

%option yylineno
%%
{null_type}		return NULL_VALUE;
\.				return DOT;
\,            	return	COMMA;
\(            	return	LP;
\)            	return	RP;
\{            	return	LCB;
\}            	return	RCB;
\;            	return	SEMICOLON;
\=            	return	ASSIGN_OP;
\+        		return	ADD;
\-        		return	SUBTRACT;
\*				return MULTIPLY;
\/				return	DIVIDE;
\%				return	MODULO;
\>				return	GREATER;
\<				return	LESS;
\<=				return	LESS_EQUAL;
\>=				return	GREATER_EQUAL;
\^				return	POWER;
\n				return	NEWLINE;
EQUALS			return	EQUALS;
AND				return	AND;
OR				return	OR;
NOT 			return	NOT;
XOR				return	XOR;
NAND 			return	NAND;
NOR				return	NOR;
STARTPROGRAM	return	START_PROGRAM;
ENDPROGRAM		return	END_PROGRAM;
PRIM			return	PRIMITIVE;
FUNC			return	FUNCTION_DECLARATION;
ENDFUNC			return	END_DECLARATION;
read_temp		return	READ_TEMPERATURE;
read_hum		return	READ_HUMIDITY;
read_air_qual	return	READ_AIR_QUALITY;
read_air_press	return	READ_AIR_PRESSURE;
read_light		return	READ_LIGHT;
read_sound_lvl	return	READ_SOUND_LEVEL;
read_timestamp	return	READ_TIMESTAMP;
set_switch_as	return	SET_SWITCH_AS;
Integer			return	INTEGER;
Real			return	REAL;
String			return	STRING;
Character		return	CHAR;
TrueOrFalse		return	BOOLEAN;
Date 			return	DATE;
Time	 		return	TIME;
DateTime		return	DATETIME;
Connection		return	CONNECTION;
Void			return	VOID;
connect_to_url	return CONNECT_TO_URL;
disconnect		return	DISCONNECT;
fetch_integer	return FETCH_INTEGER;
send_integer	return	SEND_INTEGER;
IF				return	IF;
ENDIF			return	END_IF;
ELSE			return	ELSE;
ELSEIF			return	ELSE_IF;
FOR				return	FOR;
ENDFOR			return	END_FOR;
WHILE			return	WHILE;
ENDWHILE		return	END_WHILE;
input			return	INPUT;
output			return	OUTPUT;
RETURN			return	RETURN;
{int_val}		return	INTEGER_VALUE;
{real_val} 		return	REAL_VALUE;
{char_val}		return CHAR_VALUE;
{string_val} 	return	STRING_VALUE;
{bool_val}		return BOOLEAN_VALUE;
{comment}		return COMMENT;
{date_val}		return DATE_VALUE;
{time_val}		return	TIME_VALUE;
{datetime_val}	return	DATETIME_VALUE;
{identifier}	return	IDENTIFIER;
{constant}		return CONSTANT_IDENTIFIER;
{underscore}	return UNDERSCORE;

%option yylineno;
%%

int yywrap(void){
	return 1;
}
