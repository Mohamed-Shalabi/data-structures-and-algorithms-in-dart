void main() {
  final heap = Heap<num>.max();
  heap.add(10);
  heap.add(8);
  heap.add(5);
  heap.add(4);
  heap.add(6);
  heap.add(2);
  heap.add(1);
  heap.add(3);

  print(heap.indexOf(6));
}

class Heap<Element extends Comparable<Element>> {
  final List<Element> elements;
  final _HeapType _type;

  factory Heap.max({List<Element>? elements}) => Heap._(
        _HeapType.max,
        elements: elements,
      );

  factory Heap.min({List<Element>? elements}) => Heap._(
        _HeapType.min,
        elements: elements,
      );

  Heap._(this._type, {List<Element>? elements}) : elements = elements ?? [] {
    if (!isEmpty) {
      this.elements.sort();
      final start = this.elements.length ~/ 2 - 1;
      for (var i = start; i >= 0; i--) {
        _siftDown(i);
      }
    }
  }

  bool get isEmpty => elements.isEmpty;
  Element? get peek => isEmpty ? null : elements.first;
  int get size => elements.length;

  void add(Element value) {
    elements.add(value);
    _siftUp(size - 1);
  }

  int indexOf(Element value, {int index = 0}) {
    if (index >= elements.length) {
      return -1;
    }

    if (_isFirstMorePrior(value, elements[index])) {
      return -1;
    }

    if (value == elements[index]) {
      return index;
    }

    final left = indexOf(value, index: _getLeftChildIndex(index));
    if (left != -1) return left;
    return indexOf(value, index: _getRightChildIndex(index));
  }

  Element? pop() {
    if (isEmpty) {
      return null;
    }

    _swapChildren(0, elements.length - 1);
    final value = elements.removeLast();
    _siftDown(0);
    return value;
  }

  Element? removeAt(int index) {
    final lastIndex = elements.length - 1;
    if (index < 0 || index > lastIndex) {
      return null;
    }
    if (index == lastIndex) {
      return elements.removeLast();
    }
    _swapChildren(index, lastIndex);
    final value = elements.removeLast();
    _siftDown(index);
    _siftUp(index);
    return value;
  }

  @override
  String toString() {
    return elements.toString();
  }

  int _compareNullables(rightChild, leftChild) {
    final int comparisonValue;
    if (rightChild == null && leftChild == null) {
      comparisonValue = 0;
    } else if (rightChild == null) {
      comparisonValue = -1;
    } else if (leftChild == null) {
      comparisonValue = 1;
    } else {
      comparisonValue = leftChild.compareTo(rightChild);
    }
    return comparisonValue;
  }

  Element? _getElementFromIndex(int index) {
    final Element? rightChild;
    if (index == -1) {
      rightChild = null;
    } else {
      rightChild = elements[index];
    }
    return rightChild;
  }

  void _siftDown(int index) {
    var leftChildIndex = _getLeftChildIndex(index);
    if (leftChildIndex >= elements.length) {
      leftChildIndex = -1;
    }

    var rightChildIndex = _getRightChildIndex(index);
    if (rightChildIndex >= elements.length) {
      rightChildIndex = -1;
    }

    final leftChild = _getElementFromIndex(leftChildIndex);

    final rightChild = _getElementFromIndex(rightChildIndex);

    int comparisonValue = _compareNullables(rightChild, leftChild);

    final int toBeShiftedChildIndex;
    if (comparisonValue >= 0) {
      toBeShiftedChildIndex = leftChildIndex;
    } else {
      toBeShiftedChildIndex = rightChildIndex;
    }

    final shouldShift = toBeShiftedChildIndex != -1 &&
        toBeShiftedChildIndex < elements.length &&
        getHigherInPriority(index, toBeShiftedChildIndex) ==
            toBeShiftedChildIndex;

    if (!shouldShift) {
      return;
    }

    _swapChildren(index, toBeShiftedChildIndex);
    _siftDown(toBeShiftedChildIndex);
  }

  void _siftUp(int index) {
    var parentIndex = getParentIndex(index);
    final shouldShift =
        index != 0 && getHigherInPriority(index, parentIndex) == index;
    if (!shouldShift) {
      return;
    }

    _swapChildren(index, parentIndex);
    _siftUp(parentIndex);
  }
}

enum _HeapType { min, max }

extension _HeapUtils<Element extends Comparable<Element>> on Heap<Element> {
  int getHigherInPriority(int indexA, int indexB) {
    if (indexA >= elements.length) return indexB;
    final valueA = elements[indexA];
    final valueB = elements[indexB];
    final isFirst = _isFirstMorePrior(valueA, valueB);
    return (isFirst) ? indexA : indexB;
  }

  int getParentIndex(int childIndex) {
    return (childIndex - 1) ~/ 2;
  }

  int _getLeftChildIndex(int parentIndex) {
    return 2 * parentIndex + 1;
  }

  int _getRightChildIndex(int parentIndex) {
    return 2 * parentIndex + 2;
  }

  bool _isFirstMorePrior(Element valueA, Element valueB) {
    if (_type == _HeapType.max) {
      return valueA.compareTo(valueB) > 0;
    }

    return valueA.compareTo(valueB) < 0;
  }

  void _swapChildren(int indexA, int indexB) {
    final temp = elements[indexA];
    elements[indexA] = elements[indexB];
    elements[indexB] = temp;
  }
}
