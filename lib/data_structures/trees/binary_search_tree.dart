import 'base_tree.dart';
import 'binary_tree_node.dart';

class BinarySearchTree<Element extends Comparable<Element>>
    extends BaseTree<Element, BinaryTreeNode<Element>> {
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

    return node;
  }

  @override
  bool overridableContains(Element value, BinaryTreeNode<Element>? node) {
    if (node == null) {
      return false;
    }

    if (node.value == value) {
      return true;
    }

    bool result = false;

    if (value.compareTo(node.value) > 0) {
      result = result || overridableContains(value, node.leftChild);
    } else {
      result = result || overridableContains(value, node.rightChild);
    }

    return result;
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

    return node;
  }

  @override
  String toString() {
    return root.toString();
  }
}

extension _MinFinder<Element> on BinaryTreeNode<Element> {
  BinaryTreeNode<Element> get min => leftChild?.min ?? this;
}

BinarySearchTree<num> buildExampleTree() {
  var tree = BinarySearchTree<num>();
  tree.add(3);
  tree.add(1);
  tree.add(4);
  tree.add(0);
  tree.add(2);
  tree.add(9);
  tree.add(5);
  return tree;
}

void main() {
  final tree = buildExampleTree();
  print('Tree before removal:');
  print(tree);
  tree.remove(3);
  print('Tree after removing 9:');
  print(tree);
}
