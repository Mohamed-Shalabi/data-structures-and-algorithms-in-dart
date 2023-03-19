import 'base_tree_node.dart';

class BinaryTreeNode<Element>
    extends BaseTreeNode<Element, BinaryTreeNode<Element>> {
  BinaryTreeNode<Element>? leftChild;
  BinaryTreeNode<Element>? rightChild;

  BinaryTreeNode.leaf(super.value);

  BinaryTreeNode.withChildren(
    super.value, {
    this.leftChild,
    this.rightChild,
  });

  bool get hasLeftChild => leftChild != null;

  bool get hasRightChild => rightChild != null;

  @override
  bool get canAddMore => leftChild == null || rightChild == null;

  @override
  List<BinaryTreeNode<Element>> get children =>
      List<BinaryTreeNode<Element>>.unmodifiable([
        if (leftChild != null) leftChild,
        if (rightChild != null) rightChild,
      ]);

  @override
  void add(BinaryTreeNode<Element> node) {
    if (leftChild == null) {
      leftChild = node;
    } else {
      rightChild = node;
    }
  }

  @override
  String toString() => _diagram(this);

  String _diagram(
    BinaryTreeNode<Element>? node, [
    String top = '',
    String root = '',
    String bottom = '',
  ]) {
    if (node == null) {
      return '$root null\n';
    }
    if (node.leftChild == null && node.rightChild == null) {
      return '$root ${node.value}\n';
    }
    final a = _diagram(
      node.rightChild,
      '$top ',
      '$top┌──',
      '$top│ ',
    );
    final b = '$root${node.value}\n';
    final c = _diagram(
      node.leftChild,
      '$bottom│ ',
      '$bottom└──',
      '$bottom ',
    );
    return '$a$b$c';
  }

  void traverseInOrder(ElementAction<Element> action) {
    _traverseInOrder((node) => action(node.value));
  }

  void traversePreOrder(ElementAction<Element> action) {
    _traversePreOrder((node) => action(node.value));
  }

  void traversePostOrder(ElementAction<Element> action) {
    _traversePostOrder((node) => action(node.value));
  }

  void _traverseInOrder(NodeAction<Element, BinaryTreeNode<Element>> action) {
    leftChild?._traverseInOrder(action);
    action(this);
    rightChild?._traverseInOrder(action);
  }

  void _traversePreOrder(NodeAction<Element, BinaryTreeNode<Element>> action) {
    action(this);
    leftChild?._traversePreOrder(action);
    rightChild?._traversePreOrder(action);
  }

  void _traversePostOrder(NodeAction<Element, BinaryTreeNode<Element>> action) {
    leftChild?._traversePostOrder(action);
    rightChild?._traversePostOrder(action);
    action(this);
  }

  List<Element?> serializeToList() {
    final list = <Element?>[];

    _traversePreOrder((node) {
      list.add(node.value);

      if (!node.hasLeftChild) {
        list.add(null);
      }

      if (!node.hasRightChild) {
        list.add(null);
      }
    });

    return list;
  }

  static BinaryTreeNode<Element>? deserializeFromList<Element>(
    List<Element?> serializedList,
  ) {
    if (serializedList.isEmpty) return null;
    final value = serializedList.removeAt(0);
    if (value == null) return null;
    final node = BinaryTreeNode<Element>.leaf(value);
    node.leftChild = deserializeFromList(serializedList);
    node.rightChild = deserializeFromList(serializedList);
    return node;
  }

  bool isBinarySearchTree() {
    final rightChildComparable = rightChild?.value as Comparable<Element>?;
    final leftChildComparable = leftChild?.value as Comparable<Element>?;

    var isBiggerThanLeft = (leftChildComparable?.compareTo(value) ?? -1) < 0;
    var isSmallerThanRight = (rightChildComparable?.compareTo(value) ?? 1) > 0;

    if (!isSmallerThanRight || !isBiggerThanLeft) {
      return false;
    } else {
      final leftResult = leftChild?.isBinarySearchTree() ?? true;
      final rightResult = rightChild?.isBinarySearchTree() ?? true;

      return leftResult && rightResult;
    }
  }
}

void main() {
  final zero = BinaryTreeNode<num>.leaf(0);
  final one = BinaryTreeNode<num>.leaf(1);
  final five = BinaryTreeNode<num>.leaf(5);
  final seven = BinaryTreeNode<num>.leaf(7);
  final eight = BinaryTreeNode<num>.leaf(8);
  final nine = BinaryTreeNode<num>.leaf(9);
  seven.leftChild = five;
  five.leftChild = zero;
  five.leftChild = one;
  seven.rightChild = nine;
  nine.leftChild = eight;

  final tree = seven;

  print(tree);
  print(tree.isBinarySearchTree());
}
