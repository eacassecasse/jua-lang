package compiler.frontend.lexer.adapter;

import java.util.List;
import java.util.ArrayList;
import java_cup.runtime.ComplexSymbolFactory.ComplexSymbol;
import compiler.frontend.lexer.generated.JuaLexer;
import compiler.frontend.lexer.tokens.Token;
import compiler.frontend.lexer.tokens.TokenType;
import compiler.frontend.lexer.adapter.TokenMapper;

/**
 *
 */
public final class LexerAdapter {

	private final JuaLexer lexer;
	
	public LexerAdapter(JuaLexer lexer) {
		this.lexer = lexer;
	}

	public Token nextToken() {
		try {
			ComplexSymbol symbol =
				(ComplexSymbol) lexer.next_token();

			return TokenMapper.map(symbol);
		} catch (Exception e) {
			throw new IllegalStateException(
					"Failed to read next token.", e);
		}
	}


	public List<Token> tokenize() {
		List<Token> tokens = new ArrayList<>();
		
		Token token;	
		
		do {
			token = nextToken();
			tokens.add(token);
		} while (token.getType() != TokenType.EOF);

		return tokens;
	}
}
