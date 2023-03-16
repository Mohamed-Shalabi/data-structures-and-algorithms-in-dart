import 'binary_tree_node.dart';

class BinarySearchTree<Element extends Comparable<Element>> {
  BinaryTreeNode<Element>? root;

  void add(Element value) {
    root = _insertAt(root, value);
  }

  BinaryTreeNode<Element> _insertAt(
    BinaryTreeNode<Element>? node,
    Element value,
  ) {
    if (node == null) {
      return BinaryTreeNode.leaf(value);
    }

    if (value.compareTo(node.value) > 0) {
      node.leftChild = _insertAt(node.leftChild, value);
    } else {
      node.rightChild = _insertAt(node.rightChild, value);
    }

    return node;
  }

  bool contains(Element value) {
    return _contains(value, root);
  }

  bool _contains(Element value, BinaryTreeNode<Element>? node) {
    if (node == null) {
      return false;
    }

    if (node.value == value) {
      return true;
    }

    bool result = false;

    if (value.compareTo(node.value) > 0) {
      result = result || _contains(value, node.leftChild);
    } else {
      result = result || _contains(value, node.rightChild);
    }

    return result;
  }

  void remove(Element value) {
    root = _remove(root, value);
  }

  BinaryTreeNode<Element>? _remove(
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
      node.rightChild = _remove(node.rightChild, node.value);
    } else if (value.compareTo(node.value) > 0) {
      node.leftChild = _remove(node.leftChild, value);
    } else {
      node.rightChild = _remove(node.rightChild, value);
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
