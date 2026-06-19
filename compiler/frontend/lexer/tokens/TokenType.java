package compiler.frontend.lexer.tokens;

/**
 * All token types recognized by the Jua lexer.
 */
public enum TokenType {

	// ===============================================
	// Special
	// ===============================================
	
	EOF,

	// ===============================================
	// Identifiers
	// ===============================================

	IDENTIFIER,

	// ===============================================
	// Literals
	// ===============================================

	INTEGER_LITERAL,
	// FLOAT_LITERAL, # UNCOMMENT TO IMPLEMENT
	STRING_LITERAL,
	// DOUBLE_LITERAL, # UNCOMMENT TO IMPLEMENT

	// ================================================
	// Keywords
	// ================================================

	FUNCTION,
	RETURN,

	IF,
	ELSE,

	WHILE,
	FOR,
	// REPEAT, # UNCOMMENT TO IMPLEMENT
	IN,

	BREAK,
	CONTINUE,

	OBJECT,
	TRAIT,
	INTERFACE,

	USES,

	IMPORT,
	EXPORT,

	CREATE,
	MUTABLE,
	// CONSTANT, # UNCOMMENT TO IMPLEMENT

	TRUE,
	FALSE,
	NULL,

	END,

	// ================================================
	// Operators
	// ================================================

	PLUS,
	MINUS,
	STAR,
	SLASH,
	PERCENT,

	ASSIGN,

	EQUAL_EQUAL,
	BANG_EQUAL,
	// STAR_EQUAL, # UNCOMMENT TO IMPLEMENT
	// OVER_EQUAL, # UNCOMMENT TO IMPLEMENT

	LESS,
	LESS_EQUAL,

	GREATER,
	GREATER_EQUAL,

	AND,
	OR,
	NOT,

	// ================================================
	// Delimiters
	// ================================================

	LEFT_PAREN,
	RIGHT_PAREN,

	LEFT_BRACKET,
	RIGHT_BRACKET,

	COMMA,
	COLON,
	DOT,

	// ================================================
	// Layout
	// ================================================

	NEWLINE;

	public boolean isKeyword() {
		return switch (this) {
			case FUNCTION,
			     RETURN,
			     IF,
			     ELSE,
			     WHILE,
			     FOR,
			     IN,
			     BREAK,
			     CONTINUE,
			     OBJECT,
			     TRAIT,
			     INTERFACE,
			     USES,
			     IMPORT,
			     EXPORT,
			     CREATE,
			     MUTABLE,
			     TRUE,
			     FALSE,
			     NULL,
			     END -> true;
			
			default -> false;
		};
	}

	public boolean isLiteral() {
		return switch (this) {
			case INTEGER_LITERAL,
			     STRING_LITERAL,
			     TRUE,
			     FALSE,
			     NULL -> true;

			default -> false;
		};
	}

	public boolean isOperator() {
		return switch (this) {
			case PLUS,
			     MINUS,
			     STAR,
			     SLASH,
			     PERCENT,
			     ASSIGN,
			     EQUAL_EQUAL,
			     BANG_EQUAL,
			     LESS,
			     LESS_EQUAL,
			     GREATER,
			     GREATER_EQUAL,
			     AND,
			     OR,
			     NOT -> true;

			default -> false;
		};
	}
}
