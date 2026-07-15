package compiler.frontend.ast.visitor;

import java.util.Objects;

import compiler.frontend.ast.AstNode;
import compiler.frontend.ast.ProgramNode;
import compiler.frontend.ast.declarations.VariableDeclarationNode;
import compiler.frontend.ast.expressions.IdentifierExpressionNode;
import compiler.frontend.ast.expressions.BinaryExpressionNode;
import compiler.frontend.ast.expressions.GroupingExpressionNode;
import compiler.frontend.ast.expressions.LiteralExpressionNode;
import compiler.frontend.ast.expressions.UnaryExpressionNode;
import compiler.frontend.ast.statements.AssignmentStatementNode;

public abstract class TraversingAstVisitor<R, C>
    extends AbstractAstVisitor<R, C> {

    protected R defaultResult(C context) {
        return null;
    }

    protected void beforeVisit(AstNode node, C context) {}

    protected void afterVisit(AstNode node, C context) {}

    protected final <RNode extends AstNode> void visit(RNode node, C context) {
        if (node != null) {
            node.accept(this, context);
        }

        defaultResult(context);
    }

    protected final void visitAll(
        Iterable<? extends AstNode> nodes,
	C context
	) {
        Objects.requireNonNull(nodes, "nodes");

        for (AstNode node : nodes) {
            visit(node, context);
        }
    }

    @Override
    public R visit(ProgramNode node, C context) {
        beforeVisit(node, context);
        visitAll(node.members(), context);
        afterVisit(node, context);
        return defaultResult(context);
    }

    @Override
    public R visit(VariableDeclarationNode node, C context) {
        beforeVisit(node, context);
        visit(node.initializer(), context);
        afterVisit(node, context);
        return defaultResult(context);
    }

    @Override
    public R visit(AssignmentStatementNode node, C context) {
        beforeVisit(node, context);
        visit(node.value(), context);
        afterVisit(node, context);
        return defaultResult(context);
    }

    @Override
    public R visit(BinaryExpressionNode node, C context) {
        beforeVisit(node, context);
        visit(node.left(), context);
        visit(node.right(), context);
        afterVisit(node, context);
        return defaultResult(context);
    }

    @Override
    public R visit(UnaryExpressionNode node, C context) {
        beforeVisit(node, context);
        visit(node.operand(), context);
        afterVisit(node, context);
        return defaultResult(context);
    }

    @Override
    public R visit(GroupingExpressionNode node, C context) {
        beforeVisit(node, context);
        visit(node.expression(), context);
        afterVisit(node, context);
        return defaultResult(context);
    }

    @Override
    public R visit(LiteralExpressionNode node, C context) {
        beforeVisit(node, context);
        afterVisit(node, context);
        return defaultResult(context);
    }

    @Override
    public R visit(IdentifierExpressionNode node, C context) {
        beforeVisit(node, context);
        afterVisit(node, context);
        return defaultResult(context);
    }
}
