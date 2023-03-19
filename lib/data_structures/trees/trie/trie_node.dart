class TrieNode<Key> {
  TrieNode({this.key, this.parent});

  Key? key;
  TrieNode<Key>? parent;

  final children = <Key, TrieNode<Key>>{};
  bool isTerminating = false;
}
