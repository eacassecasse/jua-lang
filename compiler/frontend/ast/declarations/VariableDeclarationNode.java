package compiler.frontend.ast.declarations;

import compiler.frontend.ast.expressions.ExpressionNode;
import compiler.frontend.source.SourceSpan;

public record VariableDeclarationNode(
        boolean mutable,
        String name,
        ExpressionNode initializer,
        SourceSpan span
) implements DeclarationNode {

}
