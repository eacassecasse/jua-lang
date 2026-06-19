package compiler.frontend.ast;

import java.util.List;

import compiler.frontend.source.SourceSpan;

public record ProgramNode(
        List<TopLevelNode> members,
        SourceSpan span
) implements AstNode {

}
