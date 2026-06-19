package compiler.frontend.lexer.adapter.utils;

import compiler.frontend.lexer.adapter.utils.GenericStack;
import compiler.frontend.lexer.adapter.utils.Node;

public class Stack implements GenericStack<Object> {

	private Node top;
	private int size;

	public Stack() {
		top = null;
		size = 0;
	}

	@Override
	public boolean isEmpty() {
		return top == null;
	}

	@Override
	public void push(Object obj) {
		Node tmp = new Node();
		tmp.setElement(obj);
		tmp.setNext(top);
		top = tmp;
		size++;
	}

	@Override
	public Object pop() {
		if (isEmpty()) {
			return null;
		}

		Object el = (Object)top.getElement();
		top = top.getNext();
		size--;

		return el;
	}

	@Override
	public Object top() {
		return (Object)top.getElement();
	}

	@Override
	public int size() {
		return size;
	}

	public void print() {
		Node node = top;

		do {
			System.out.println(node.getElement());
			node = node.getNext();
		} while (node != null);
	}
}
