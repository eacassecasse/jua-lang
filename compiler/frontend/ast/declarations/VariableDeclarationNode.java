package compiler.frontend.ast.declarations;

import compiler.frontend.ast.expressions.ExpressionNode;
import compiler.frontend.ast.visitor.AstVisitor;
import compiler.frontend.source.SourceSpan;

public record VariableDeclarationNode(
        boolean mutable,
        String name,
        ExpressionNode initializer,
        SourceSpan span
) implements DeclarationNode {

    @Override
    public <R, C> R accept(AstVisitor<R, C>  visitor, C context){
        return visitor.visit(this, context);
    }
}
