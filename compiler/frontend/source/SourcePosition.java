package compiler.frontend.source;

/**
 * Represents a position in a source file.
 *
 * Lines and colums are 1-based.
 */
public record SourcePosition(
		int line,
		int column
) {
	public SourcePosition {
		if (line < 1) {
			throw new IllegalArgumentException("line must be >= 1");
		}

		if (column < 1) {
			throw new IllegalArgumentException("column must be >= 1");
		}
	}
}
