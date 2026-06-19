package compiler.frontend.lexer.tokens;

import java.util.Objects;
import compiler.frontend.source.SourceSpan;

/**
 * Canonical token representation used by the Jua Compiler.
 */
public final class Token {
	private final TokenType type;
	private final String lexeme;
	private final Object value;
	private final SourceSpan span;

	public Token(
			TokenType type,
			String lexeme,
			Object value,
			SourceSpan span
	) {
		this.type = Objects.requireNonNull(type, "type cannot be null");
		this.lexeme = Objects.requireNonNull(lexeme, "lexeme cannot be null");
		this.span = Objects.requireNonNull(span, "span cannot be null");
		this.value = value;
	}

	public TokenType getType() {
		return this.type;
	}

	public String getLexeme() {
		return this.lexeme;
	}

	public Object getValue() {
		return this.value;
	}

	public SourceSpan getSpan() {
		return this.span;
	}

	public boolean hasValue() {
		return this.value != null;
	}

	@Override
	public String toString() {
		return "Token{" +
			"type=" + this.type +
			", lexeme=" + '\'' + this.lexeme + '\'' +
			", value=" + this.value +
			", span=" + this.span +
			'}';
	}
}
