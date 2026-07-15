package compiler.frontend.ast.visitor;

import compiler.frontend.ast.AstNode;
import compiler.frontend.ast.ProgramNode;
import compiler.frontend.ast.declarations.VariableDeclarationNode;
import compiler.frontend.ast.statements.AssignmentStatementNode;
import compiler.frontend.ast.expressions.BinaryExpressionNode;
import compiler.frontend.ast.expressions.UnaryExpressionNode;
import compiler.frontend.ast.expressions.IdentifierExpressionNode;
import compiler.frontend.ast.expressions.GroupingExpressionNode;
import compiler.frontend.ast.expressions.LiteralExpressionNode;

public abstract class AbstractAstVisitor<R, C>
    implements AstVisitor<R, C> {

    protected R defaultVisit(AstNode node, C context) {
        throw new UnsupportedOperationException(
            "Visitor "
                + getClass().getSimpleName()
                + "does not support "
                + node.getClass().getSimpleName()
        );
    }

    public R visit(ProgramNode node, C context) {
        return defaultVisit(node, context);
    }

    public R visit(VariableDeclarationNode node, C context) {
        return defaultVisit(node, context);
    }

    public R visit(AssignmentStatementNode node, C context) {
        return defaultVisit(node, context);
    }

    public R visit(BinaryExpressionNode node, C context) {
        return defaultVisit(node, context);
    }

    public R visit(UnaryExpressionNode node, C context) {
        return defaultVisit(node, context);
    }

    public R visit(GroupingExpressionNode node, C context) {
        return defaultVisit(node, context);
    }

    public R visit(LiteralExpressionNode node, C context) {
        return defaultVisit(node, context);
    }

    public R visit(IdentifierExpressionNode node, C context) {
        return defaultVisit(node, context);
    }
}
