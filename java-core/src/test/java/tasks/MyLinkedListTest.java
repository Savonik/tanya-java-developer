package tasks;

import org.junit.Assert;
import org.junit.Test;
import tasks.linked_list.MyLinkedList;

import java.util.Random;

/**
 * @author Tatiana Savonik
 */
public class MyLinkedListTest {

    @Test
    public void testMyLinkedListContains() {
        MyLinkedList<Integer> list = fullListByNumbers(5);

        Assert.assertTrue(list.contains(4));
    }

    @Test
    public void testMyLinkedListDoesNotContains() {
        MyLinkedList<Integer> list1 = fullListByNumbers(6);

        Assert.assertFalse(list1.contains(6));
        Assert.assertFalse(list1.contains(-8));
    }

    @Test
    public void testMyLinkedListGet() {
        MyLinkedList<String> list2 = new MyLinkedList<>();
        list2.add("first");
        list2.add("second");
        list2.add("third");

        Assert.assertEquals("third", list2.get(2));
    }

    @Test
    public void testMyLinkedListAdd() {
        MyLinkedList<String> list3 = new MyLinkedList<>();

        Assert.assertTrue(list3.add("forth"));
    }

    @Test
    public void testMyLinkedListClear() {
        MyLinkedList<Integer> list4 = fullListByNumbers(16);
        list4.clear();
        Assert.assertEquals(0, list4.size());
    }

    MyLinkedList<Integer> fullListByNumbers(int numberElements) {
        MyLinkedList<Integer> list = new MyLinkedList<>();
        for (int i = 0; i < numberElements; i++) {
            list.add(i);
        }
        return list;
    }
}
