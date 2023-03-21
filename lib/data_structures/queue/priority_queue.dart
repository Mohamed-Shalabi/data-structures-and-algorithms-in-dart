import 'package:dart_dsa/data_structures/queue/queue_interface.dart';

import '../trees/binary/heap.dart';

class PriorityQueue<Element extends Comparable<Element>>
    implements QueueInterface<Element> {
  PriorityQueue.max({List<Element>? elements})
      : _heap = Heap.max(elements: elements);
  PriorityQueue.min({List<Element>? elements})
      : _heap = Heap.min(elements: elements);

  final Heap<Element> _heap;

  @override
  Element dequeue() {
    final result = _heap.pop();
    if (result != null) {
      return result;
    }

    throw DequeuingEmptyQueueException();
  }

  @override
  bool enqueue(Element element) {
    _heap.add(element);
    return true;
  }

  @override
  bool get isEmpty => _heap.isEmpty;

  @override
  Element get peek {
    final result = _heap.peek;
    if (result != null) {
      return result;
    }

    throw PeekingEmptyQueueException();
  }
}

void main() {
  var priorityQueue = PriorityQueue.max(
    elements: <num>[1, 12, 3, 4, 1, 6, 8, 7],
  );
  while (!priorityQueue.isEmpty) {
    print(priorityQueue.dequeue());
  }
}
