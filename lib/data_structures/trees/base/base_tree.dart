import 'package:meta/meta.dart';

import 'base_tree_node.dart';

abstract class BaseTree<Element, Node extends BaseTreeNode<Element, Node>> {
  Node? root;

  @nonVirtual
  void add(Element value) {
    root = insertAt(root, value);
  }

  @visibleForOverriding
  Node insertAt(Node? node, Element value);

  @nonVirtual
  bool contains(Element value) {
    return overridableContains(value, root);
  }

  @visibleForOverriding
  bool overridableContains(Element value, Node? node);

  @nonVirtual
  void remove(Element value) {
    root = overridableRemove(root, value);
  }

  @visibleForOverriding
  Node? overridableRemove(Node? node, Element value);
}
