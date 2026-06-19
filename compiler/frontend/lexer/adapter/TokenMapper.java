package compiler.frontend.lexer.adapter;

import java.util.Map;
import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.function.Function;

import java_cup.runtime.ComplexSymbolFactory.ComplexSymbol;
import java_cup.runtime.ComplexSymbolFactory.Location;

import compiler.frontend.source.SourcePosition;
import compiler.frontend.source.SourceSpan;
import compiler.frontend.lexer.tokens.Token;
import compiler.frontend.lexer.tokens.TokenType;
import compiler.frontend.parser.generated.sym;

/**
 *
 *
 *
 */
public final class TokenMapper {
	private static final Map<String, TokenType> TOKEN_TYPES =
		Arrays.stream(TokenType.values())
		.collect(Collectors.toUnmodifiableMap(
					TokenType::name,
					Function.identity()
					));

	private TokenMapper() {
		throw new AssertionError(
				"Utility class cannot be instantiated.");
	}

	public static Token map(ComplexSymbol symbol) {
		int terminal = symbol.sym;
		String name = sym.terminalNames[terminal];

		TokenType type = TOKEN_TYPES.get(name);	

		if (type == null) {
			throw new IllegalStateException(
					"No TokenType mapping found for terminal: " + name);
		}


		Location left = symbol.getLeft();
		Location right = symbol.getRight();

		SourceSpan span =
			new SourceSpan(
					new SourcePosition(
						left.getLine(),
						left.getColumn()
					),
					new SourcePosition(
						right.getLine(),
						right.getColumn()
					)
			);

		String lexeme = symbol.value == null ? "" : symbol.value.toString();
		Object value = normalizeValue(type, lexeme);

		return new Token(
				type,
				lexeme,
				value,
				span
		);

	}

	private static Object normalizeValue(
			TokenType type,
			String lexeme
	) {
		return switch (type) {
			case INTEGER_LITERAL -> Integer.parseInt(lexeme);
			case TRUE -> true;
			case FALSE -> false;
			case NULL -> null;
			default -> lexeme;
		};
	}
}
