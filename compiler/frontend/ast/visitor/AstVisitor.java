package compiler.frontend.ast.visitor;

import compiler.frontend.ast.ProgramNode;
import compiler.frontend.ast.declarations.VariableDeclarationNode;
import compiler.frontend.ast.statements.AssignmentStatementNode;
import compiler.frontend.ast.expressions.BinaryExpressionNode;
import compiler.frontend.ast.expressions.UnaryExpressionNode;
import compiler.frontend.ast.expressions.IdentifierExpressionNode;
import compiler.frontend.ast.expressions.GroupingExpressionNode;
import compiler.frontend.ast.expressions.LiteralExpressionNode;


public interface AstVisitor<R, C> {
	R visit(ProgramNode node, C context);
	R visit(VariableDeclarationNode node, C context);
	R visit(AssignmentStatementNode node, C context);
	R visit(BinaryExpressionNode node, C context);
	R visit(UnaryExpressionNode node, C context);
	R visit(IdentifierExpressionNode node, C context);
	R visit(GroupingExpressionNode node, C context);
	R visit(LiteralExpressionNode node, C context);
}
