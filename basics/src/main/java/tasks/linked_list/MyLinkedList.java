package tasks.linked_list;

import java.lang.reflect.Array;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.NoSuchElementException;

/**
 * This class is realisation of LinkedList
 *
 * @author Tatiana Savonik
 */
public class MyLinkedList<E> implements List<E> {

    private int size = 0;
    Node<E> first;
    Node<E> last;

    public int size() {
        return size;
    }

    public boolean isEmpty() {
        return (size == 0);
    }

    public void clear() {
        for (Node<E> node = first; node != null; ) {
            Node<E> next = node.next;
            node.item = null;
            node.next = null;
            node.prev = null;
            node = next;
        }
        first = last = null;
        size = 0;
    }

    @Override
    public boolean contains(Object o) {
        Node<E> current = first;
        for (int i = 0; i < size(); i++) {
            if (current.item.equals(o)) {
                return true;
            }
            current = current.next;
        }
        return false;
    }

    @Override
    public Iterator<E> iterator() {
        return listIterator();
    }

    @Override
    public Object[] toArray() {
        Object[] objects = new Object[size];
        Node<E> current = first;
        for (int i = 0; i < size(); i++) {
            objects[i] = current.item;
            current = current.next;
        }
        return objects;
    }

    @Override
    public <T> T[] toArray(T[] a) {
        if (a.length < size) {
            a = (T[]) Array.newInstance(a.getClass().getComponentType(), size);
        }
        if (a.length > size) {
            a[size] = null;
        }
        Object[] result = a;
        Node<E> current = first;
        for (int i = 0; i < size; i++) {
            result[i] = current.item;
            current = current.next;
        }
        return a;
    }

    @Override
    public boolean add(E e) {
        if (isEmpty()) {
            first = new Node<>(null, e, null);
            last = first;
        } else {
            last.next = new Node<>(last, e, null);
            last = last.next;
        }
        size++;
        return last.item == e;
    }

    @Override
    public boolean remove(Object o) {
        Node<E> current = first;
        for (int i = 0; i < size(); i++) {
            if (current.item.equals(o)) {
                remove(i);
                return true;
            }
            current = current.next;
        }
        return false;
    }

    @Override
    public boolean containsAll(Collection<?> c) {
        Node<E> current = first;
        int count = 0;
        for (int i = 0; i < size(); i++) {
            if (count == c.size()) {
                return true;
            }
            if (c.contains(current.item)) {
                count++;
            }
            current = current.next;
        }
        return count == c.size();
    }

    @Override
    public boolean addAll(Collection<? extends E> c) {
        boolean added = false;
        for (E e : c) {
            add(e);
            added = true;
        }
        return added;
    }

    @Override
    public boolean addAll(int index, Collection<? extends E> c) {
        boolean added = false;
        for (E e : c) {
            add(index, e);
            added = true;
        }
        return added;
    }

    @Override
    public boolean removeAll(Collection<?> c) {
        boolean removed = false;
        for (Object o : c) {
            if (contains(o)) {
                remove(o);
                removed = true;
            }
        }
        return removed;
    }

    @Override
    public boolean retainAll(Collection<?> c) {
        boolean retained = false;
        for (Object o : c) {
            if (!contains(o)) {
                remove(o);
                retained = true;
            }
        }
        return retained;
    }

    @Override
    public E get(int index) {
        if (index >= size()) {
            throw new NoSuchElementException();
        }
        Node<E> current = first;
        for (int i = 0; i < size(); i++) {
            if (i == index) {
                return current.item;
            }
            current = current.next;
        }
        return null;
    }

    @Override
    public E set(int index, E element) {
        if (index >= size()) {
            throw new NoSuchElementException();
        }
        Node<E> current = first;
        for (int i = 0; i < size(); i++) {
            if (i == index) {
                current.item = element;
                return current.item;
            }
            current = current.next;
        }
        return null;
    }

    @Override
    public void add(int index, E element) {
        if (index > size) {
            throw new NoSuchElementException();
        }
        Node<E> current = first;
        for (int i = 0; i < size(); i++) {
            if (i == index) {
                current.prev.next = new Node<>(current.prev, element, current);
                current.prev = current.prev.next;
                size++;
                return;
            }
            current = current.next;
        }
    }

    @Override
    public E remove(int index) {
        if (index > size) {
            throw new IndexOutOfBoundsException();
        }
        Node<E> current = first;
        for (int i = 0; i < size(); i++) {
            if (i == index) {
                current.prev.next = current.next;
                current.next.prev = current.prev;
                size--;
                return current.item;
            }
            current = current.next;
        }
        return null;
    }

    @Override
    public int indexOf(Object o) {
        Node<E> current = first;
        for (int i = 0; i < size(); i++) {
            if (current.item.equals(o)) {
                return i;
            }
            current = current.next;
        }
        return -1;
    }

    @Override
    public int lastIndexOf(Object o) {
        int index = -1;
        Node<E> current = first;
        for (int i = 0; i < size(); i++) {
            if (current.item.equals(o)) {
                index = i;
            }
            current = current.next;
        }
        return index;
    }

    @Override
    public ListIterator<E> listIterator() {
        return new MyListIterator<>(this);
    }

    @Override
    public ListIterator<E> listIterator(int index) {
        if (index < 0 || index > size) {
            throw new IndexOutOfBoundsException();
        }
        return new MyListIterator<>(this, index);
    }

    @Override
    public List<E> subList(int fromIndex, int toIndex) {
        if (fromIndex < 0 || toIndex > size || fromIndex >= toIndex) {
            throw new IndexOutOfBoundsException();
        }
        Node<E> current = first;
        List<E> list = new MyLinkedList<>();
        for (int i = 0; i < size; i++) {
            if (i >= fromIndex && i <= toIndex) {
                list.add(current.item);
            }
            current = current.next;
        }
        return list;
    }
}
