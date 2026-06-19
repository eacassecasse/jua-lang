package compiler.frontend.ast.expressions;

import compiler.frontend.source.SourceSpan;

public record LiteralExpressionNode(
        Object value,
        SourceSpan span
) implements ExpressionNode {

}
