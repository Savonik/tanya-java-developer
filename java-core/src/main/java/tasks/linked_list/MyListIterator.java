package tasks.linked_list;

import java.util.ListIterator;

/**
 * @author Tatiana Savonik
 */
public class MyListIterator<E> implements ListIterator<E> {
    private MyLinkedList<E> list;
    private Node<E> node;
    private int index;

    public MyListIterator(MyLinkedList<E> list) {
        this.list = list;
        this.node = new Node<>(null, null, list.first);
        this.index = -1;
    }

    public MyListIterator(MyLinkedList<E> list, int index) {
        this.list = list;
        this.node = list.first;
        for (int i = 0; i < index; i++) {
            this.node = node.next;
        }
        this.index = index;
    }

    @Override
    public boolean hasNext() {
        return node.next != null;
    }

    @Override
    public E next() {
        if (node.next == null) {
            return null;
        }
        node = node.next;
        index++;
        return node.item;
    }

    @Override
    public boolean hasPrevious() {
        return node.prev != null;
    }

    @Override
    public E previous() {
        if (node.prev == null) {
            return null;
        }
        node = node.prev;
        index--;
        return node.item;
    }

    @Override
    public int nextIndex() {
        return index + 1;
    }

    @Override
    public int previousIndex() {
        return index - 1;
    }

    @Override
    public void remove() {
        node.prev.next = node.next;
        node.next.prev = node.prev;
        node = node.next;
    }

    @Override
    public void set(E e) {
        node.item = e;
    }

    @Override
    public void add(E e) {
        node.next = new Node<>(node, e, node.next);
        node.next.next.prev = node.next;
    }
}
