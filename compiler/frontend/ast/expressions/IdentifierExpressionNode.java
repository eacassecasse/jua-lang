package compiler.frontend.ast.expressions;

import compiler.frontend.source.SourceSpan;

public record IdentifierExpressionNode(
        String name,
        SourceSpan span
) implements ExpressionNode {

}
