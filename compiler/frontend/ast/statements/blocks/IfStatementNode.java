 package compiler.frontend.ast.statements.blocks;

import compiler.frontend.ast.expressions.ExpressionNode;
import compiler.frontend.ast.statements.StatementNode;
import compiler.frontend.ast.visitor.AstVisitor;

import compiler.frontend.source.SourceSpan;

public record IfStatementNode(
        String target,
        ExpressionNode value,
        SourceSpan span
) implements StatementNode {

    @Override
    public <R, C> R accept(AstVisitor<R, C> visitor, C context) {
        throw new UnsupportedOperationException("");
    }
}
