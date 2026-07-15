package compiler.frontend.ast.printer;

import compiler.frontend.ast.AstNode;
import compiler.frontend.ast.TopLevelNode;
import compiler.frontend.ast.ProgramNode;
import compiler.frontend.ast.declarations.VariableDeclarationNode;
import compiler.frontend.ast.statements.AssignmentStatementNode;
import compiler.frontend.ast.expressions.BinaryExpressionNode;
import compiler.frontend.ast.expressions.LiteralExpressionNode;
import compiler.frontend.ast.expressions.IdentifierExpressionNode;
import compiler.frontend.ast.expressions.UnaryExpressionNode;
import compiler.frontend.ast.expressions.GroupingExpressionNode;

import compiler.frontend.ast.visitor.TraversingAstVisitor;

import compiler.frontend.printer.rendering.TreeRenderer;
import compiler.frontend.printer.rendering.UnicodeTreeTheme;

import java.util.Objects;
import java.util.List;


public final class AstPrinter extends TraversingAstVisitor<Void, Void> {

    private TreeRenderer renderer;
    private boolean isCurrentNodeLast;

    public AstPrinter() {
        this.isCurrentNodeLast = false;
    }

    public String print(ProgramNode program) {
        Objects.requireNonNull(program, "program");

	this.renderer = new TreeRenderer(UnicodeTreeTheme.INSTANCE);
	this.isCurrentNodeLast = false;
        visit(program, null);
        return renderer.toString();
    }

    /**
     * @param node
     * @return
     */
    @Override
    public Void visit(ProgramNode node, Void context) {
        renderer.root("Program");
	renderChildren(node.members(), context);
	return null;
    }

    /**
     * @param node
     * @return
     */
    @Override
    public Void visit(VariableDeclarationNode node, Void context) {
        renderNode(
            "VariableDeclaration",
            () -> {
                renderProperty(
                    "mutable",
                    node.mutable(),
                    false);

                boolean hasInitializer = node.initializer() != null;

                renderProperty(
                    "name",
                    node.name(),
                    !hasInitializer);

                if (hasInitializer) {
                    renderChild(
                        node.initializer(),
                        true,
			context);
                }
            });

        return null;
    }

    /**
     * @param node
     * @return
     */
    @Override
    public Void visit(AssignmentStatementNode node, Void context) {
        renderNode(
            "AssignmentStatement",
            () -> {
                renderProperty(
                    "target",
                    node.target(),
                    false
                );

                renderChild(
                    node.value(),
                    true,
		    context
                );
            });

        return null;
    }

    /**
     * @param node
     * @return
     */
    @Override
    public Void visit(BinaryExpressionNode node, Void context) {
        renderNode(
            "BinaryExpression",
            () -> {
                renderProperty(
                    "operator",
                    node.operator(),
                    false);

                renderChild(
                    node.left(),
                    false,
		    context);

                renderChild(
                    node.right(),
                    true,
		    context);
            });

        return null;
    }

    /**
     * @param node
     * @return
     */
    @Override
    public Void visit(UnaryExpressionNode node, Void context) {
        renderNode(
            "UnaryExpression",
            () -> {
                renderProperty(
                    "operator",
                    node.operator(),
                    false
                );

                renderChild(
                    node.operand(),
                    true,
		    context
                );
            });

        return null;
    }

    /**
     * @param node
     * @return
     */
    @Override
    public Void visit(GroupingExpressionNode node, Void context) {
        renderNode(
            "GroupingExpression",
            () -> {
                renderChild(
                    node.expression(),
                    true,
		    context
                );
            });

        return null;
    }

    /**
     * @param node
     * @return
     */
    @Override
    public Void visit(LiteralExpressionNode node, Void context) {
        renderNode(
            literalType(node.value()),
            () -> renderProperty(
                "value",
                node.value(),
                true
            ));

        return null;
    }

    /**
     * @param node
     * @return
     */
    @Override
    public Void visit(IdentifierExpressionNode node, Void context) {
        renderNode(
            "Identifier",
            () -> {
                renderProperty(
                    "name",
                    node.name(),
                    true);
            });

        return null;
    }

    private void renderNode(String name, Runnable body) {
        renderer.beginNode(name, this.isCurrentNodeLast);
	body.run();
	renderer.endNode();
    }

    private void renderProperty(String name, Object value, boolean isLast) {
        renderer.attribute(name, value, isLast);
    }

    private void renderChild(AstNode child, boolean isLast, Void context) {
        
	    if (child == null) {
		    return;
	    }
	boolean previousContext = this.isCurrentNodeLast;
	this.isCurrentNodeLast = isLast;

	visit(child, context);

	this.isCurrentNodeLast = previousContext;
    }

    private void renderChildren(List<? extends AstNode> children, Void context) {
	    if (children == null) {
		    return;
	    }

	    boolean previousContext = this.isCurrentNodeLast;

	    for (int i = 0; i < children.size(); i++) {
		    this.isCurrentNodeLast = (i == children.size() - 1);
		    visit(children.get(i), context);
	    }

	    this.isCurrentNodeLast = previousContext;
    }

    private String literalType(Object value) {
        switch (value) {
            case null -> {
                return "NullLiteral";
            }
            case Boolean b -> {
                return "BooleanLiteral";
            }
            case Integer i -> {
                return "IntegerLiteral";
            }
            case Long l -> {
                return "LongLiteral";
            }
            case Float v -> {
                return "FloatLiteral";
            }
            case Double d -> {
                return "DoubleLiteral";
            }

            case String s -> {
                return "StringLiteral";
            }

            default -> {
                return "Literal";
            }
        }

    }
}
