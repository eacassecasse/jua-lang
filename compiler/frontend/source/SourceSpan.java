package compiler.frontend.source;

/**
 * Represents a source range.
 */
public record SourceSpan(
		SourcePosition start,
		SourcePosition end
) {
	public SourceSpan {
		if (start == null) {
			throw new IllegalArgumentException("start cannot be null");
		}

		if (end == null) {
			throw new IllegalArgumentException("end cannot be null");
		}
	}
}
