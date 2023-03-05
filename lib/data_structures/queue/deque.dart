enum DequeDirection { front, back }

abstract class DequeInterface<Element> {
  bool get isEmpty;
  Element peek(DequeDirection from);
  bool enqueue(Element element, DequeDirection to);
  Element dequeue(DequeDirection from);
}

class DequeList<Element> implements DequeInterface<Element> {
  DequeList() : _list = [];

  final List<Element> _list;

  @override
  Element dequeue(DequeDirection from) {
    if (isEmpty) {
      throw DequeuingEmptyDequeException();
    }

    return from == DequeDirection.front
        ? _list.removeAt(0)
        : _list.removeLast();
  }

  @override
  bool enqueue(Element element, DequeDirection to) {
    if (to == DequeDirection.front) {
      _list.insert(0, element);
    } else {
      _list.add(element);
    }

    return true;
  }

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  Element peek(DequeDirection from) {
    final int index;
    switch (from) {
      case DequeDirection.front:
        index = 0;
        break;
      case DequeDirection.back:
        index = _list.length - 1;
        break;
    }

    return _list[index];
  }
}

abstract class DequeException with Exception {
  DequeException(this.message);

  final String message;
}

class PeakingEmptyDequeException extends DequeException {
  PeakingEmptyDequeException() : super('tried to peak an empty queue');
}

class DequeuingEmptyDequeException extends DequeException {
  DequeuingEmptyDequeException() : super('tried to pop an empty queue');
}
