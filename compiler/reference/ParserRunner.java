package compiler.reference;

import java.io.FileReader;
import java.util.Arrays;
import java.util.List;

import compiler.frontend.parser.generated.JuaParser;
import compiler.frontend.lexer.generated.JuaLexer;
import compiler.frontend.ast.ProgramNode;
import compiler.frontend.ast.printer.AstPrinter;

import java_cup.runtime.ComplexSymbolFactory;

public final class ParserRunner {

    public static void main(String[] args) throws Exception {

        if (args.length != 1) {
            System.err.println(
                "Usage: ParserRunner <source-file>"
            );
            System.exit(1);
        }

        String sourceFile = args[0];

        ComplexSymbolFactory symbolFactory =
                new ComplexSymbolFactory();

	AstPrinter printer = new AstPrinter();

        JuaLexer lexer =
                new JuaLexer(
                        new FileReader(sourceFile),
                        symbolFactory
                );

        JuaParser parser =
                new JuaParser(
                        lexer,
                        symbolFactory
                );

        parser.debug_stack();

        ProgramNode program =
                (ProgramNode) parser.parse().value;

        System.out.println(printer.print(program));
    }
}
