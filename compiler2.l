%{
#include <stdio.h>
#include <stdlib.h>


int keyword_count = 0;
int identifier_count = 0;
int number_count = 0;
int symbol_count = 0;
int logical_op_count = 0;
int math_op_count = 0;
int unknown_count = 0;
int comment_count = 0;
int newline_count = 0;

%}


%%


"~" 	{ 
    		char c = input();
    		while (c != '\n' && c != EOF) {
       			c = input();
    		}
    		printf("This is a single line comment\n");
    		comment_count++;
    	}



"~~" 	{ 
    		printf("This is for Multiple line comment start\n");
    		char demo = input();
    
    		while (1) {
        		// Reading characters until found a '~' or reached EOF
        		while (demo != '~' && demo != EOF) {
            			demo = input();
        		}
        		demo = input(); // Read the next character after '~'
        
        		// Check if the next character is also '~', indicating the end of the comment
        		if (demo == '~') {
            			break;
        		}
    		}
    
    		printf("Multiple Line comment End here\n");
    		comment_count++;
	}


"represent"	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"yell"		{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"during"        	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"within"           	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"range"           	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"cond"           	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"cond_again"     	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"finish_cond"      	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"given"           	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"display"          	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"integer"          	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"real"          	{ printf("KEYWORD: %s\n", yytext); keyword_count++;; }
"var"         	{ printf("KEYWORD: %s\n", yytext); keyword_count++;; }
"bland"            	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"attach"          	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"phase"        	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"change" 		{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"sample"        	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"normal"         	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"pull"        	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }
"arrange"          	{ printf("KEYWORD: %s\n", yytext); keyword_count++; }

['\n']		{ printf("Newline\n"); newline_count++; }


"=="                { printf("LOGICAL OPERATOR: EQUAL (==)\n"); logical_op_count++; }
"!="                { printf("LOGICAL OPERATOR: NOT EQUAL (!=)\n"); logical_op_count++; }
">="                { printf("LOGICAL OPERATOR: GREATER THAN OR EQUAL (>=)\n"); logical_op_count++; }
"<="                { printf("LOGICAL OPERATOR: LESS THAN OR EQUAL (<=)\n"); logical_op_count++; }
"&&"                { printf("LOGICAL OPERATOR: AND (&&)\n"); logical_op_count++; }
"||"                { printf("LOGICAL OPERATOR: OR (||)\n"); logical_op_count++; }
"!"                 { printf("LOGICAL OPERATOR: NOT (!)\n"); logical_op_count++; }


"+"                 { printf("MATH OPERATOR: PLUS (+)\n"); math_op_count++; }
"-"                 { printf("MATH OPERATOR: MINUS (-)\n"); math_op_count++; }
"*"                 { printf("MATH OPERATOR: MULTIPLY (*)\n"); math_op_count++; }
"/"                 { printf("MATH OPERATOR: DIVIDE (/)\n"); math_op_count++; }
"%"                 { printf("MATH OPERATOR: MODULO (%%)\n"); math_op_count++; }
"^"                 { printf("MATH OPERATOR: POWER (^)\n"); math_op_count++; }


[\{\}\(\)\[\];,]    { printf("SYMBOL: %s\n", yytext); symbol_count++; }
"$"                 { printf("SYMBOL: Dollar ($)\n"); symbol_count++; }
"@"                 { printf("SYMBOL: At (@)\n"); symbol_count++; }


[a-zA-Z_][a-zA-Z0-9_]*    { printf("Identifier: %s\n", yytext); identifier_count++; }


[0-9]+\.[0-9]+      { printf("Floating-Point Number: %s\n", yytext); number_count++; }
[0-9]+              { printf("Integer: %s\n", yytext); number_count++; }

.                   { printf("Unknown: %s\n", yytext); unknown_count++; }


%%


int main(int argc, char *argv[]) {
    FILE *input_file = fopen("input.txt", "r"); // Open the input file for reading
    FILE *output_file = fopen("output.txt", "w"); // Open the output file for writing
    
    if (!input_file) {
        fprintf(stderr, "Error opening input.txt\n");
        return 1;
    }

    if (!output_file) {
        fprintf(stderr, "Error opening output.txt\n");
        return 1;
    }

    yyin = input_file; // Set the input stream to the file
    yyout = output_file; // Set the output stream to the file
    
    printf("Starting lexical analysis...\n");
    yylex(); // Start the lexer

    // Print token counts to the output file
    fprintf(output_file, "\nToken Counts:\n");
    fprintf(output_file, "Keywords: %d\n", keyword_count);
    fprintf(output_file, "Identifiers: %d\n", identifier_count);
    fprintf(output_file, "Numbers: %d\n", number_count);
    fprintf(output_file, "Symbols: %d\n", symbol_count);
    fprintf(output_file, "Logical Operators: %d\n", logical_op_count);
    fprintf(output_file, "Math Operators: %d\n", math_op_count);
    fprintf(output_file, "New line: %d\n", newline_count);
    fprintf(output_file, "Comments: %d\n", comment_count);
    fprintf(output_file, "Unknowns: %d\n", unknown_count);

    fclose(input_file); // Close the input file
    fclose(output_file); // Close the output file

    return 0;
}

// Required by Flex to indicate the end of input 
int yywrap() {
    return 1;
}




