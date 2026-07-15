package compiler.frontend.ast.expressions;

import compiler.frontend.ast.visitor.AstVisitor;
import compiler.frontend.source.SourceSpan;

public record GroupingExpressionNode(
        ExpressionNode expression,
        SourceSpan span
) implements ExpressionNode {

    @Override
    public <R, C> R accept(AstVisitor<R, C>  visitor, C context) {
        return visitor.visit(this, context);
    }
}
