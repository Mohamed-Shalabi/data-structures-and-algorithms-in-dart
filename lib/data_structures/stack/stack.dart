class Stack<Element> {
  Stack.empty() : _storage = <Element>[];

  Stack.fromIterable(Iterable<Element> iterable) : _storage = List.of(iterable);

  final List<Element> _storage;

  bool get isEmpty => _storage.isEmpty;

  void push(Element element) => _storage.add(element);

  Element pop() {
    if (isEmpty) {
      throw PopingEmptyStackException();
    }
    return _storage.removeLast();
  }

  Element get peak => _storage.last;

  @override
  String toString() {
    return '--- Top ---\n'
        '${_storage.reversed.join('\n')}'
        '\n-----------';
  }
}

abstract class StackException with Exception {
  final String message;

  StackException(this.message);
}

class PopingEmptyStackException extends StackException {
  PopingEmptyStackException() : super('Trying to pop an empty stack');
}

List<Element> _reverseList<Element>(List<Element> list) {
  final reversedList = <Element>[];

  final stack = Stack.fromIterable(list);

  while (!stack.isEmpty) {
    reversedList.add(stack.pop());
  }

  return reversedList;
}

bool isStringParenthesesBalanced(String input) {
  try {
    final stack = Stack<String>.empty();
    final chars = input.runes.map((e) => String.fromCharCode(e));

    for (final char in chars) {
      if (char == '(') {
        stack.push(char);
      } else {
        stack.pop();
      }
    }
    return stack.isEmpty;
  } on PopingEmptyStackException {
    return false;
  }
}
