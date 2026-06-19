package compiler.frontend.ast.expressions;

import compiler.frontend.ast.expressions.operators.BinaryOperator;
import compiler.frontend.source.SourceSpan;

public record BinaryExpressionNode(
        ExpressionNode left,
        BinaryOperator operator,
        ExpressionNode right,
        SourceSpan span
) implements ExpressionNode {
}
