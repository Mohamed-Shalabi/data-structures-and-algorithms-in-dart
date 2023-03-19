import 'trie_node.dart';

class Trie<IterableElement extends Iterable<Element>, Element> {
  final TrieNode<Element> root = TrieNode();

  void insert(IterableElement iterable) {
    var current = root;
    for (var element in iterable) {
      current.children[element] ??= TrieNode(
        key: element,
        parent: current,
      );
      current = current.children[element]!;
    }

    current.isTerminating = true;
  }

  bool contains(IterableElement iterable) {
    var current = root;
    for (var codeUnit in iterable) {
      final child = current.children[codeUnit];
      if (child == null) {
        return false;
      }
      current = child;
    }

    return current.isTerminating;
  }

  void remove(IterableElement iterable) {
    var current = root;
    for (final codeUnit in iterable) {
      final child = current.children[codeUnit];
      if (child == null) {
        return;
      }
      current = child;
    }

    if (!current.isTerminating) {
      return;
    }

    current.isTerminating = false;
    bool hasParent() => current.parent != null;
    bool hasNoChildren() => current.children.isEmpty;
    bool isTerminating() => current.isTerminating;
    bool isNonTerminatingLeaf() =>
        hasParent() && hasNoChildren() && !isTerminating();
    while (isNonTerminatingLeaf()) {
      current.parent!.children.remove(current.key!);
      current = current.parent!;
    }
  }
}
