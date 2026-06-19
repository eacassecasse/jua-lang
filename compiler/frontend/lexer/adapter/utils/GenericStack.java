package compiler.frontend.lexer.adapter.utils;

/**
 * Defines a generic interface for stack
 */

public interface GenericStack<T> {
	public boolean isEmpty(); // Verifies if the stack is empty
	public void push(T type); // Adds a new element to the top of the stack
	public T pop(); // Removes and returns the removed element from the top of the stack
	public T top(); // Returns the current top element of the stack
	public int size(); // Returns the size of the stack
}
