package compiler.frontend.ast;

import compiler.frontend.source.SourceSpan;
import compiler.frontend.ast.declarations.DeclarationNode;
import compiler.frontend.ast.statements.StatementNode;
import compiler.frontend.ast.expressions.ExpressionNode;

/**
 * Base interface for all AST nodes.
 */
public interface AstNode
/*permits ProgramNode,
        compiler.frontend.ast.declarations.DeclarationNode,
        compiler.frontend.ast.statements.StatementNode,
        compiler.frontend.ast.expressions.ExpressionNode */ {

    SourceSpan span();
}
