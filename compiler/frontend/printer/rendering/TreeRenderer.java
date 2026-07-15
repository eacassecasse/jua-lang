package compiler.frontend.printer.rendering;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Objects;


/**
 *
 * Renders hierarchical structures using Unicode tree characters.
 *
 * <p>This class is intentionally independent of the AST and the
 * Visitor Pattern. It only knows how to render tree structures.</p>
 */

public final class TreeRenderer {
    private final static String NEWLINE = "\n";
    private final TreeTheme theme;
    private final Deque<Boolean> continuationLevels;
    private final StringBuilder builder;
    private boolean rootRendered = false;

    public TreeRenderer(TreeTheme theme) {
        this.theme = Objects.requireNonNull(theme, "theme");
        this.builder = new StringBuilder();
        this.continuationLevels = new ArrayDeque<>();
    }

    public void root(String name) {
        Objects.requireNonNull(name, "name");

        if (rootRendered) {
            throw new IllegalStateException("Root node has already been rendered");
        }

        append(name);
        newline();
        rootRendered = true;
    }

    public void attribute(String name, Object value, boolean last) {
        Objects.requireNonNull(name, "name");
        Objects.requireNonNull(value, "value");

        writeIndentation();

        append(last ? theme.lastBranchPrefix() : theme.branchPrefix());
        append(name);
        append(": ");
        append(value);

        newline();
    }

    public void beginNode(String name, boolean last) {
        Objects.requireNonNull(name, "name");

	if (!rootRendered) {
		throw new IllegalStateException("Must render root node before rendering children.");
	}

        writeIndentation();
        append(last ? theme.lastBranchPrefix() : theme.branchPrefix());
        append(name);
        newline();
        continuationLevels.addLast(!last);
    }

    public void endNode() {
        if (continuationLevels.isEmpty()) {
            throw new IllegalStateException("No node scope is currently open.");
        }

        continuationLevels.removeLast();
    }

    private void append(Object text) {
        builder.append(text);
    }

    private void newline() {
        append(NEWLINE);
    }

    private void writeIndentation() {
        for (boolean drawVertical : continuationLevels) {
            append(drawVertical ? theme.verticalIndent() : theme.emptyIndent());
        }
    }

    @Override
    public String toString() {
        if (rootRendered && !continuationLevels.isEmpty()) {
            throw new IllegalStateException("Rendering finished with unclosed node scopes.");
        }
        return builder.toString();
    }
}
