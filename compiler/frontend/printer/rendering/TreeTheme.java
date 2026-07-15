package compiler.frontend.printer.rendering;

/**
 * Defines the symbols used to render hierarchical tree structures.
 *
 * <p>A {@code TreeTheme} encapsulates the visual representation of tree
 * branches and indentation, allowing different rendering styles
 * (for example Unicode, ASCII or compact representations) without
 * changing the rendering algorithm.</p>
 *
 * <p>Implementations are immutable and thread-safe.</p>
 */
public interface TreeTheme {

    /**
     * Returns the branch prefix used for non-terminal children.
     */
    String branchPrefix();

    /**
     * Returns the branch prefix used for the last child.
     */
    String lastBranchPrefix();

    /**
     * Returns the indentation used when vertical continuation
     * should be drawn.
     */
    String verticalIndent();

    /**
     * Returns the indentation used when no continuation
     * should be drawn.
     */
    String emptyIndent();
}
