import '../../../data_structures/trees/binary/heap.dart';

List<Element> heapsortPremade<Element extends Comparable<Element>>(
  List<Element> list,
) {
  final heap = Heap<Element>.min(
    elements: list.toList(),
  );

  final sorted = <Element>[];
  while (!heap.isEmpty) {
    final value = heap.pop();
    sorted.add(value!);
  }

  return sorted;
}

extension Heapsort<Element extends Comparable<Element>> on List<Element> {
  int _leftChildIndex(int parentIndex) {
    return 2 * parentIndex + 1;
  }

  int _rightChildIndex(int parentIndex) {
    return 2 * parentIndex + 2;
  }

  void _swapValues(int indexA, int indexB) {
    final temp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = temp;
  }

  void _siftDown({required int start, required int end}) {
    var parent = start;
    while (true) {
      final left = _leftChildIndex(parent);
      final right = _rightChildIndex(parent);
      var chosen = parent;

      if (left < end && this[left].compareTo(this[chosen]) > 0) {
        chosen = left;
      }

      if (right < end && this[right].compareTo(this[chosen]) > 0) {
        chosen = right;
      }
      if (chosen == parent) return;
      _swapValues(parent, chosen);
      parent = chosen;
    }
  }

  void heapsortInPlace() {
    if (isEmpty) {
      return;
    }

    final start = length ~/ 2 - 1;
    for (var i = start; i >= 0; i--) {
      _siftDown(start: i, end: length);
    }

    for (var end = length - 1; end > 0; end--) {
      _swapValues(0, end);
      _siftDown(start: 0, end: end);
    }
  }
}
