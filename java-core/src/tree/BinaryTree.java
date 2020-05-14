/*
Create binary tree with random values in nodes (no need to sort the tree).
User should be able to set up the count of tree levels;
User should be able to print “leaves“;
User should be able to print whole tree;
User should be able to print exact level of tree;
Example of whole tree printing (tree with 4 level):
 */


package tree;

import java.util.*;

public class BinaryTree {
    private Node root;
    private int maxLevel;
    private Random r = new Random(10);
    private int currentLevel = 1;

    public static void main(String[] args) {
        Node root = new Node(5);
        BinaryTree tree = new BinaryTree(root, 6);
        tree.buildTree();
        tree.printWholeTree();
        tree.printTreeLeaves();
        tree.printExactLevel(4);
    }

    public BinaryTree(Node root, int maxLevel) {
        this.root = root;
        this.maxLevel = maxLevel;
    }

    public void buildTree() {
        currentLevel = 1;
        List<Node> l = new ArrayList<>();
        l.add(root);
        fill(l);
    }

    public void printWholeTree() {
        System.out.println("Whole tree:");
        currentLevel = 1;
        List<Node> l = new ArrayList<>();
        l.add(root);
        print(l);
    }

    public void printTreeLeaves() {
        System.out.println("Leaves of tree:");
        currentLevel = 1;
        List<Node> l = new ArrayList<>();
        l.add(root);
        printLeaves(l);
    }

    public void printExactLevel(int exactLevel) {
        if (exactLevel > maxLevel) {
            System.out.println("Wrong data. Number of Levels = " + maxLevel);
            return;
        }
        System.out.println("Level " + exactLevel + " of tree");
        currentLevel = 1;
        List<Node> l = new ArrayList<>();
        l.add(root);
        printLevel(l, exactLevel);
    }

    private void printLevel(List<Node> root, int exactLevel) {
        if (currentLevel > exactLevel) {
            return;
        }
        List<Node> nodeList = new ArrayList<>();
        for (Node next : root) {
            nodeList.add(next.getLeft());
            nodeList.add(next.getRight());
            if (currentLevel == exactLevel) {
                System.out.print(next.value + "  ");
            }
        }
        if (currentLevel == exactLevel) {
            System.out.println();
        }
        currentLevel++;
        printLevel(nodeList, exactLevel);
    }

    private void printLeaves(List<Node> root) {
        if (currentLevel > maxLevel) {
            return;
        }
        List<Node> nodeList = new ArrayList<>();
        for (Node next : root) {
            nodeList.add(next.getLeft());
            nodeList.add(next.getRight());
            if (currentLevel == maxLevel) {
                System.out.print(next.value + "  ");
            }
        }
        if (currentLevel == maxLevel) {
            System.out.println();
        }
        currentLevel++;
        printLeaves(nodeList);
    }

    private void print(List<Node> root) {
        if (currentLevel > maxLevel) {
            return;
        }
        List<Node> nodeList = new ArrayList<>();
        for (Node next : root) {
            nodeList.add(next.getLeft());
            nodeList.add(next.getRight());
            System.out.print(next.value + "  ");
        }
        currentLevel++;
        System.out.println();
        print(nodeList);
    }

    private void fill(List<Node> root) {
        if (currentLevel > maxLevel) {
            return;
        }
        List<Node> nodeList = new ArrayList<>();
        for (Node next : root) {
            next.setLeft(new Node(r.nextInt(10)));
            next.setRight(new Node(r.nextInt(10)));
            nodeList.add(next.getLeft());
            nodeList.add(next.getRight());
        }
        currentLevel++;
        fill(nodeList);
    }
}
