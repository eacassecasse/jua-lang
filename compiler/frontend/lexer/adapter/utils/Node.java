package compiler.frontend.lexer.adapter.utils;

public class Node {
	private Object element;
	private Node next;

	public Node(Object element, Node next) {
		this.element = element;
		this.next = next;
	}

	public Node() {
		this(null, null);
	}

	public Node(Object element) {
		this.element = element;
	}

	public Object getElement() {
		return element;
	}

	public void setElement(Object element) {
		this.element = element;
	}

	public Node getNext() {
		return next;
	}

	public void setNext(Node next) {
		this.next = next;
	}

	public boolean hasNext() {
		return next != null;
	}
}
