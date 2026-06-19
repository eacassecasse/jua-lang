package compiler.frontend.ast.expressions;

import compiler.frontend.source.SourceSpan;

public record GroupingExpressionNode(
        ExpressionNode expression,
        SourceSpan span
) implements ExpressionNode {
}
