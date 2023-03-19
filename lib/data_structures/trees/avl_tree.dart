import 'binary_search_tree.dart';
import 'binary_tree_node.dart';

class AVLTree<Element extends Comparable<Element>>
    extends BinarySearchTree<Element> {
  @override
  BinaryTreeNode<Element> insertAt(
    BinaryTreeNode<Element>? node,
    Element value,
  ) {
    if (node == null) {
      return BinaryTreeNode.leaf(value);
    }

    if (value.compareTo(node.value) > 0) {
      node.leftChild = insertAt(node.leftChild, value);
    } else {
      node.rightChild = insertAt(node.rightChild, value);
    }

    node = node.balanced();

    return node;
  }

  @override
  BinaryTreeNode<Element>? overridableRemove(
    BinaryTreeNode<Element>? node,
    Element value,
  ) {
    if (node == null) {
      return null;
    }

    if (value == node.value) {
      if (node.isLeaf) {
        return null;
      }

      if (node.leftChild == null) {
        return node.rightChild;
      }

      if (node.rightChild == null) {
        return node.leftChild;
      }

      node.value = node.rightChild!.min.value;
      node.rightChild = overridableRemove(node.rightChild, node.value);
    } else if (value.compareTo(node.value) > 0) {
      node.leftChild = overridableRemove(node.leftChild, value);
    } else {
      node.rightChild = overridableRemove(node.rightChild, value);
    }

    node = node.balanced();

    return node;
  }
}

extension<Element extends Comparable<Element>> on BinaryTreeNode<Element> {
  int get balanceFactor => leftHeight - rightHeight;
  int get leftHeight => leftChild?.height ?? -1;
  int get rightHeight => rightChild?.height ?? -1;

  BinaryTreeNode<Element> balanced() {
    switch (balanceFactor) {
      case 2:
        final left = leftChild;
        if (left != null && left.balanceFactor == -1) {
          return rotateLeftRight(this);
        } else {
          return rotateRight(this);
        }
      case -2:
        final right = rightChild;
        if (right != null && right.balanceFactor == 1) {
          return rotateRightLeft(this);
        } else {
          return rotateLeft(this);
        }
      default:
        return this;
    }
  }

  BinaryTreeNode<Element> rotateLeft(BinaryTreeNode<Element> node) {
    final pivot = node.rightChild;
    if (pivot == null) {
      return node;
    }

    node.rightChild = pivot.leftChild;
    pivot.leftChild = node;
    node = pivot;

    return pivot;
  }

  BinaryTreeNode<Element> rotateRight(BinaryTreeNode<Element> node) {
    final pivot = node.leftChild;
    if (pivot == null) {
      return node;
    }

    node.leftChild = pivot.rightChild;
    pivot.rightChild = node;
    node = pivot;

    return pivot;
  }

  BinaryTreeNode<Element> rotateRightLeft(BinaryTreeNode<Element> node) {
    if (node.rightChild == null) {
      return node;
    }

    node.rightChild = rotateRight(node.rightChild!);
    return rotateLeft(node.leftChild!);
  }

  BinaryTreeNode<Element> rotateLeftRight(BinaryTreeNode<Element> node) {
    if (node.leftChild == null) {
      return node;
    }

    node.leftChild = rotateLeft(node.leftChild!);
    return rotateRight(node.rightChild!);
  }
}

extension<Element extends Comparable<Element>> on BinaryTreeNode<Element> {
  BinaryTreeNode<Element> get min => leftChild?.min ?? this;
}

void main() {
  final tree = AVLTree<num>();
  for (var i = 0; i < 35; i++) {
    tree.add(i);
  }

  tree.remove(0);
  tree.remove(1);
  tree.remove(2);
  tree.remove(3);
  tree.remove(4);
  tree.remove(5);
  tree.remove(6);
  tree.remove(7);
  tree.remove(8);
  tree.remove(9);
  tree.remove(10);
  tree.remove(13);
  tree.remove(14);
  tree.remove(12);
  tree.remove(11);
  tree.remove(25);
  tree.remove(33);
  print(tree);
}
