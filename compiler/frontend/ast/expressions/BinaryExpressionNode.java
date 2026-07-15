package compiler.frontend.ast.expressions;

import compiler.frontend.ast.expressions.operators.BinaryOperator;
import compiler.frontend.ast.visitor.AstVisitor;
import compiler.frontend.source.SourceSpan;

public record BinaryExpressionNode(
        ExpressionNode left,
        BinaryOperator operator,
        ExpressionNode right,
        SourceSpan span
) implements ExpressionNode {

    @Override
    public <R, C> R accept(AstVisitor<R, C> visitor, C context) {
        return visitor.visit(this, context);
    }
}
