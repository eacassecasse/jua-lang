package compiler.reference;

import java.io.*;
import java.util.*;
import java_cup.runtime.ComplexSymbolFactory;
import java.nio.file.*;
import compiler.frontend.lexer.tokens.TokenType;
import compiler.frontend.lexer.tokens.Token;
import compiler.frontend.lexer.adapter.LexerAdapter;
import compiler.frontend.lexer.generated.JuaLexer;

public final class LexerRunner {
	public static void main(String[] args) throws Exception {
		try(Reader reader =
				Files.newBufferedReader(
					Path.of(args[0]))) {
			ComplexSymbolFactory symbolFactory = new ComplexSymbolFactory();
			JuaLexer lexer = new JuaLexer(reader, symbolFactory);

			LexerAdapter adapter = new LexerAdapter(lexer);
			List<Token> tokens = adapter.tokenize();
			System.out.println("TOKENS FOUND");
			System.out.println(Arrays.toString(tokens.toArray()));
					}
	}
}
