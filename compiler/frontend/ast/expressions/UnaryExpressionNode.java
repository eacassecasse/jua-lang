package compiler.frontend.ast.expressions;

import compiler.frontend.ast.expressions.operators.UnaryOperator;
import compiler.frontend.source.SourceSpan;

public record UnaryExpressionNode(
        UnaryOperator operator,
        ExpressionNode operand,
        SourceSpan span
) implements ExpressionNode {
}
