package compiler.frontend.printer.rendering;

/**
 * Canonical tree rendering theme used by the Jua compiler.
 *
 * <p>This implementation defines the stable textual representation used by
 * snapshot tests, parser validation and debugging output.</p>
 *
 * <p>The formatting defined by this theme is considered part of the
 * compiler's validation infrastructure and should remain stable across
 * releases unless explicitly changed.</p>
 *
 * <p>This class is immutable and thread-safe.</p>
 */
public final class UnicodeTreeTheme implements TreeTheme {

    /**
     * Shared immutable instance.
     */
    public static final UnicodeTreeTheme INSTANCE =
        new UnicodeTreeTheme();

    /**
     * Prevent external instantiation.
     */
    private UnicodeTreeTheme() {
    }

    @Override
    public String branchPrefix() {
        return "\u251C\u2500\u2500\u2500 ";
    }

    @Override
    public String lastBranchPrefix() {
        return "\u2514\u2500\u2500\u2500 ";
    }

    @Override
    public String verticalIndent() {
        return "\u2502    ";
    }

    @Override
    public String emptyIndent() {
        return "     ";
    }

}
