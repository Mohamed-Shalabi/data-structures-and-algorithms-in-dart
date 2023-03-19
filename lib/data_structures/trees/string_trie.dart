import 'package:dart_dsa/data_structures/trees/trie.dart';
import 'package:dart_dsa/data_structures/trees/trie_node.dart';

class StringTrie extends Trie<Iterable<int>, int> {
  void insertString(String text) {
    super.insert(text.codeUnits);
  }

  void removeString(String text) {
    super.remove(text.codeUnits);
  }

  bool containsString(String text) {
    return super.contains(text.codeUnits);
  }

  List<String> getAllStrings(String previousPattern, TrieNode<int> current) {
    List<String> result = [];

    if (current.isTerminating) {
      result.add(previousPattern + String.fromCharCode(current.key!));
    }

    for (final child in current.children.values) {
      final newPattern = previousPattern + String.fromCharCode(current.key!);
      result.addAll(getAllStrings(newPattern, child));
    }

    return result;
  }

  List<String> matchPrefix(String prefix) {
    var current = root;
    for (final codeUnit in prefix.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) {
        return [];
      }

      current = child;
    }

    return _moreMatches(prefix, current);
  }

  List<String> _moreMatches(String prefix, TrieNode<int> current) {
    var result = <String>[];

    if (current.isTerminating) {
      result.add(prefix + String.fromCharCode(current.key!));
    }

    for (final TrieNode<int> child in current.children.values) {
      final newPrefix = prefix + String.fromCharCode(child.key!);
      result.addAll(_moreMatches(newPrefix, child));
    }

    return result;
  }
}
