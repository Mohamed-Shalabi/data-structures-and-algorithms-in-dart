import 'package:dart_dsa/data_structures/queue/queue_interface.dart';

class QueueList<Element> implements QueueInterface<Element> {
  QueueList() : _list = [];
  final List<Element> _list;

  @override
  Element dequeue() {
    if (isEmpty) {
      throw DequeuingEmptyQueueException();
    }

    return _list.removeAt(0);
  }

  @override
  bool enqueue(Element element) {
    _list.add(element);
    return true;
  }

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  Element get peek {
    if (isEmpty) {
      throw PeakingEmptyQueueException();
    }

    return _list.first;
  }

  @override
  String toString() => _list.toString();
}

void main() {
  final queue = QueueList<String>();
  queue.enqueue("R");
  print(queue);
  queue.enqueue("B");
  print(queue);
  queue.enqueue("E");
  print(queue);
  queue.enqueue("W");
  print(queue);
  queue.dequeue();
  print(queue);
}
