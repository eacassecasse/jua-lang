 package compiler.frontend.ast.statements;

import compiler.frontend.ast.expressions.ExpressionNode;
import compiler.frontend.ast.visitor.AstVisitor;
import compiler.frontend.source.SourceSpan;

public record AssignmentStatementNode(
        String target, // TODO: Change the target type to ExpressionNode to support more shapes.
        ExpressionNode value,
        SourceSpan span
) implements StatementNode {

    @Override
    public <R, C> R accept(AstVisitor<R, C> visitor, C context) {
        return visitor.visit(this, context);
    }
}
