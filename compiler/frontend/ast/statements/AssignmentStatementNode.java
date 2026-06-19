package compiler.frontend.ast.statements;

import compiler.frontend.ast.expressions.ExpressionNode;
import compiler.frontend.source.SourceSpan;

public record AssignmentStatementNode(
        String target,
        ExpressionNode value,
        SourceSpan span
) implements StatementNode {

}
