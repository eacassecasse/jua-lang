package compiler.frontend.ast;

import java.util.List;

import compiler.frontend.ast.visitor.AstVisitor;
import compiler.frontend.source.SourceSpan;

import compiler.frontend.ast.TopLevelNode;
import compiler.frontend.ast.AstNode;

public record ProgramNode(
        List<TopLevelNode> members,
        SourceSpan span
) implements AstNode {

    @Override
    public <R, C> R accept(AstVisitor<R, C> visitor, C context) {
        return visitor.visit(this, context);
    }
}
