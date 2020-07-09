package tasks.linked_list;

/**
 * This class is realisation of node for linked list
 *
 * @author Tatiana Savonik
 */
 class Node<E> {
    E item;
    Node<E> next;
    Node<E> prev;

    Node(Node<E> prev, E element, Node<E> next) {
        this.item = element;
        this.next = next;
        this.prev = prev;
    }
}
