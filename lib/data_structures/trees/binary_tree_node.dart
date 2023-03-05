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
    leftChild?._traverseInOrder(action);
    rightChild?._traverseInOrder(action);
  }

  void _traversePostOrder(NodeAction<Element, BinaryTreeNode<Element>> action) {
    leftChild?._traverseInOrder(action);
    rightChild?._traverseInOrder(action);
    action(this);
  }

  List<Element?> serializeToList() {
    final list = <Element?>[];

    _traverseInOrder((node) {
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
      List<Element?> serializedList) {
    if (serializedList.isEmpty || serializedList.first == null) {
      return null;
    }

    final root = BinaryTreeNode.withChildren(
      serializedList.first as Element,
      leftChild: deserializeFromList(serializedList.sublist(1)),
      rightChild: deserializeFromList(serializedList.sublist(2)),
    );

    return root;
  }
}
