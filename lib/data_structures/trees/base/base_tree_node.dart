// ignore_for_file: library_private_types_in_public_api

import 'dart:math' as math;

import 'package:meta/meta.dart';

import '../../queue/queue_list.dart';

typedef ElementAction<Element> = void Function(Element element);

typedef NodeAction<Element, Node extends BaseTreeNode<Element, Node>> = void
    Function(Node node);

/// CAUTION: The generics obliged me to create this class to make the [add] method
/// more helpful during compile time
/// So, DO NOT ADD ANY LETTER HERE except if you know what you are doing
/// DO NOT ask me about using dynamic, DO NOT EVEN TRY TO SAY WHY! I HATE IT!
abstract class _BaseTreeNode<Element> {
  _BaseTreeNode(this.value);

  Element value;

  bool get canAddMore;
  List<int> get childrenHeights;
  int get height;
  bool get hasChildren;
  bool get isLeaf => height == 0;
}

/// [Element] is the element type of the tree
/// [Node] is determined during extension ONLY to help add method know the type of the node
abstract class BaseTreeNode<Element, Node extends _BaseTreeNode<Element>>
    extends _BaseTreeNode<Element> {
  BaseTreeNode(super.value);
  List<Node> get children;

  @override
  @nonVirtual
  List<int> get childrenHeights => children.map((e) => e.height).toList();

  @override
  @nonVirtual
  bool get hasChildren => children.isNotEmpty;

  @override
  @nonVirtual
  int get height {
    if (hasChildren) {
      return 1 + childrenHeights.max;
    } else {
      return 1;
    }
  }

  @visibleForOverriding
  void add(Node node);

  @nonVirtual
  void addNode(Node node) {
    if (hasChildren) {
      add(node);
    }

    throw NodeNoMoreAvailableChildrenException();
  }
}

abstract class TreeNodeException with Exception {
  final String message;

  TreeNodeException(this.message);
}

class NodeNoMoreAvailableChildrenException<Element> extends TreeNodeException {
  NodeNoMoreAvailableChildrenException()
      : super('Children have reached mac size');
}

class TreeNodeSearchNoElementException<Element> extends TreeNodeException {
  TreeNodeSearchNoElementException(Element element)
      : super('Value $element not found');
}

extension on List<int> {
  int get max {
    return reduce((value, element) => math.max(value, element));
  }
}

extension BaseTreeNodeTraversal<Element,
    Node extends BaseTreeNode<Element, Node>> on Node {
  void forEachDepthFirst(ElementAction<Element> action) {
    _forEachNodeDepthFirst(
      (node) => action(node.value),
    );
  }

  void forEachLevelFirst(ElementAction<Element> action) {
    _forEachNodeLevelFirst(
      (node) => action(node.value),
    );
  }

  BaseTreeNode<Element, Node> searchDepthFirst(Element searchTerm) {
    BaseTreeNode<Element, Node>? result;
    _forEachNodeDepthFirst((node) {
      if (node == searchTerm) {
        result = node;
      }
    });

    if (result == null) {
      throw TreeNodeSearchNoElementException(searchTerm);
    }

    return result!;
  }

  BaseTreeNode<Element, Node> searchLevelFirst(Element searchTerm) {
    BaseTreeNode<Element, Node>? result;
    _forEachNodeLevelFirst((node) {
      if (node == searchTerm) {
        result = node;
      }
    });

    if (result == null) {
      throw TreeNodeSearchNoElementException(searchTerm);
    }

    return result!;
  }

  void _forEachNodeDepthFirst(NodeAction<Element, Node> action) {
    action(this);

    for (final child in children) {
      child._forEachNodeDepthFirst(action);
    }
  }

  void _forEachNodeLevelFirst(NodeAction<Element, Node> action) {
    final queue = QueueListImpl<Node>();

    while (!queue.isEmpty) {
      final node = queue.dequeue();
      action(node);

      for (final child in node.children) {
        queue.enqueue(child);
      }
    }
  }
}
