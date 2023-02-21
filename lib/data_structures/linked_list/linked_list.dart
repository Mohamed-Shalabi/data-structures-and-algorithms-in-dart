class LinkedList<Element> extends Iterable<Element>
    implements Iterator<Element> {
  _Node<Element>? _head;
  _Node<Element>? _tail;
  _Node<Element>? _iteratorPointer;
  LinkedList()
      : _head = null,
        _tail = null;

  @override
  Element get current => _iteratorPointerCurrent.value;

  @override
  bool get isEmpty => _head == null || _tail == null;

  @override
  Iterator<Element> get iterator => this;

  _Node<Element> get _iteratorPointerCurrent => _iteratorPointer!;

  void append(Element element) {
    final node = _Node._leaf(element);

    if (isEmpty) {
      _head = node;
      _tail = _head;
    } else {
      _tail!._child = node;
      _tail = node;
    }
  }

  void insert(Element element, int index) {
    final listLength = length;
    if (listLength == 0) {
      push(element);
    }

    final parentNode = _nodeAt(index);
    final childNode = parentNode.child;
    if (childNode == null) {
      append(element);
      return;
    }

    final node = _Node._(value: element, child: childNode);
    parentNode._child = node;
  }

  @override
  bool moveNext() {
    if (_iteratorPointer == null) {
      _iteratorPointer = _head;
    } else {
      _iteratorPointer = _iteratorPointer!.child;
    }

    return _iteratorPointer != null;
  }

  void push(Element element) {
    final node = _Node._leaf(element);

    if (isEmpty) {
      _head = node;
      _tail = _head;
    } else {
      node._child = _head;
      _head = node;
    }
  }

  Element remove(Element element) {
    return _removeElement(element).value;
  }

  Element removeAt(int index) {
    _checkIndex(index);
    final node = _nodeAt(index);
    return remove(node.value);
  }

  Element pop() => removeAt(0);

  Element removeLast() => removeAt(length - 1);

  @override
  String toString() {
    if (isEmpty) {
      return 'Empty LinkedList';
    } else {
      return _head.toString();
    }
  }

  void _checkIndex(int index) {
    final listLength = length;
    if (listLength == 0) {
      throw LinkedListEmptyException();
    }

    if (index >= listLength) {
      throw LinkedListElementNotFoundException._range(
        index,
        0,
        listLength - 1,
      );
    }
  }

  _Node<Element> _deleteNode(
    _Node<Element> node, [
    _Node<Element>? parentNode,
  ]) {
    bool isHead = parentNode == null;
    bool isTail = node.child == null;

    if (isHead && isTail) {
      _head = null;
      _tail = null;
      node._child = null;
      return node;
    }

    if (isHead) {
      _head = node.child;
      node._child = null;
      return node;
    }

    if (isTail) {
      _tail = parentNode;
      node._child = null;
      return node;
    }

    parentNode._child = node.child;
    node._child = null;
    return node;
  }

  void _iterate([void Function(_Node<Element> node, int index)? action]) {
    if (isEmpty) {
      return;
    }

    void performAction(_Node<Element> node, int index) {
      if (action != null) {
        action(node, index);
      }
    }

    var index = 0;
    var pointingNode = _head!;
    performAction(pointingNode, index);
    while (pointingNode.hasChild) {
      index++;
      pointingNode = pointingNode.child!;
      performAction(pointingNode, index);
    }
  }

  _Node<Element> _nodeAt(int index) {
    _checkIndex(index);

    late _Node<Element> node;
    _iterate((nodeInner, indexInner) {
      if (indexInner == index) {
        node = nodeInner;
      }
    });

    return node;
  }

  _Node<Element> _removeElement(Element element) {
    late _Node<Element> parentNode;
    late _Node<Element> node;

    bool gotNode = false;

    _iterate((nodeInner, index) {
      if (gotNode) {
        return;
      }

      if (nodeInner.hasChild) {
        if (nodeInner.child!.value == element) {
          parentNode = nodeInner;
        }
      }

      if (nodeInner.value == element) {
        node = nodeInner;
        gotNode = true;
      }
    });

    if (!gotNode) {
      throw LinkedListElementNotFoundException._search(element);
    }

    return _deleteNode(node, parentNode);
  }
}

class LinkedListElementCannotBeNullException extends LinkedListException {
  LinkedListElementCannotBeNullException()
      : super._('Node value cannot be null');
}

class LinkedListElementNotFoundException extends LinkedListException {
  LinkedListElementNotFoundException._range(
    int invalidValud,
    int min,
    int max,
  ) : super._('invalid value $invalidValud not between $min..$max');

  LinkedListElementNotFoundException._search(Object? element)
      : super._('element $element not found');
}

class LinkedListEmptyException extends LinkedListException {
  LinkedListEmptyException() : super._('trying to access an empty list');
}

abstract class LinkedListException implements Exception {
  final String message;

  LinkedListException._(this.message);

  @override
  String toString() {
    return message;
  }
}

class _Node<Element> {
  final Element value;
  _Node<Element>? _child;

  _Node._({required this.value, required _Node<Element> child})
      : _child = child;
  _Node._leaf(this.value) : _child = null;

  _Node<Element>? get child => _child;

  bool get hasChild => child != null;

  bool get isLeaf => child == null;

  @override
  String toString() {
    if (child == null) return '$value';
    return '$value -> ${child.toString()}';
  }
}
