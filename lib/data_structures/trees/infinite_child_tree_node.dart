import 'base_tree_node.dart';

class InfiniteChildTreeNode<Element>
    extends BaseTreeNode<Element, InfiniteChildTreeNode<Element>> {
  final List<InfiniteChildTreeNode<Element>> _children;

  InfiniteChildTreeNode.leaf(super.value) : _children = [];

  InfiniteChildTreeNode.withChildren({
    required Element value,
    required List<InfiniteChildTreeNode<Element>> children,
  })  : _children = children,
        super(value);

  @override
  bool get canAddMore => true;

  @override
  List<InfiniteChildTreeNode<Element>> get children {
    return List.unmodifiable(_children);
  }

  @override
  void add(InfiniteChildTreeNode<Element> node) {
    _children.add(node);
  }
}
