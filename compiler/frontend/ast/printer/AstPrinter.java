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

public final class AstPrinter {

    public String print(ProgramNode program) {
	    StringBuilder builder = new StringBuilder();

	    visitProgram(program, builder, "");

	    return builder.toString();
    }

private void visit(
        AstNode node,
        StringBuilder builder,
        String indent
) {

    if (node == null) {
        builder.append(indent)
               .append("<null>\n");
        return;
    }

    if (node instanceof ProgramNode) {

        visitProgram(
                (ProgramNode) node,
                builder,
                indent
        );

    } else if (node instanceof VariableDeclarationNode) {

        visitVariableDeclaration(
                (VariableDeclarationNode) node,
                builder,
                indent
        );

    } else if (node instanceof AssignmentStatementNode) {

        visitAssignment(
                (AssignmentStatementNode) node,
                builder,
                indent
        );

    } else if (node instanceof BinaryExpressionNode) {

        visitBinary(
                (BinaryExpressionNode) node,
                builder,
                indent
        );

    } else if (node instanceof UnaryExpressionNode) {

        visitUnary(
                (UnaryExpressionNode) node,
                builder,
                indent
        );

    } else if (node instanceof GroupingExpressionNode) {

        visitGrouping(
                (GroupingExpressionNode) node,
                builder,
                indent
        );

    } else if (node instanceof LiteralExpressionNode) {

        visitLiteral(
                (LiteralExpressionNode) node,
                builder,
                indent
        );

    } else if (node instanceof IdentifierExpressionNode) {

        visitIdentifier(
                (IdentifierExpressionNode) node,
                builder,
                indent
        );

    } else {

        builder.append(indent)
               .append(node.getClass().getSimpleName())
               .append('\n');
    }
}

private void visitProgram(
        ProgramNode node,
        StringBuilder builder,
        String indent
) {

    builder.append(indent)
           .append("Program\n");

    for (TopLevelNode member : node.members()) {

        visit(
                member,
                builder,
                indent + "  "
        );
    }
}

private void visitVariableDeclaration(
        VariableDeclarationNode node,
        StringBuilder builder,
        String indent
) {

    builder.append(indent)
           .append("VariableDeclaration")
           .append('\n');

    builder.append(indent)
           .append("  name=")
           .append(node.name())
           .append('\n');

    builder.append(indent)
           .append("  mutable=")
           .append(node.mutable())
           .append('\n');

    visit(
            node.initializer(),
            builder,
            indent + "  "
    );
}

private void visitBinary(
        BinaryExpressionNode node,
        StringBuilder builder,
        String indent
) {

    builder.append(indent)
           .append("Binary(")
           .append(node.operator())
           .append(")\n");

    visit(
            node.left(),
            builder,
            indent + "  "
    );

    visit(
            node.right(),
            builder,
            indent + "  "
    );
}

private void visitAssignment(
        AssignmentStatementNode node,
        StringBuilder builder,
        String indent
) {

    builder.append(indent)
           .append("Assignment")
           .append('\n');

    builder.append(indent)
           .append("  target=")
           .append(node.target())
           .append('\n');

    visit(
            node.value(),
            builder,
            indent + "  "
    );
}

private void visitLiteral(
        LiteralExpressionNode node,
        StringBuilder builder,
        String indent
) {

    builder.append(indent)
           .append("Literal(")
           .append(node.value())
           .append(")")
           .append('\n');
}

private void visitIdentifier(
        IdentifierExpressionNode node,
        StringBuilder builder,
        String indent
) {

    builder.append(indent)
           .append("Identifier(")
           .append(node.name())
           .append(")")
           .append('\n');
}

private void visitUnary(
        UnaryExpressionNode node,
        StringBuilder builder,
        String indent
) {

    builder.append(indent)
           .append("Unary(")
           .append(node.operator())
           .append(")")
           .append('\n');

    visit(
            node.operand(),
            builder,
            indent + "  "
    );
}

private void visitGrouping(
        GroupingExpressionNode node,
        StringBuilder builder,
        String indent
) {

    builder.append(indent)
           .append("Grouping")
           .append('\n');

    visit(
            node.expression(),
            builder,
            indent + "  "
    );
}
}
