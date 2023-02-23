import 'package:dart_dsa/data_structures/queue/queue_interface.dart';
import 'package:dart_dsa/data_structures/queue/ring_buffer.dart';

class QueueRingBuffer<Element> extends RingBuffer
    implements QueueInterface<Element> {
  QueueRingBuffer({required super.size});

  @override
  Element dequeue() {
    return popElement();
  }

  @override
  bool enqueue(Element element) {
    addElement(element);
    return true;
  }

  @override
  bool get isEmpty => isEmptyRingBuffer;

  @override
  Element get peek => currentElement();

  //TODO: implement toString method to order elements depending on head and tail
}

void main() {
  final queue = QueueRingBuffer<String>(size: 3);
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
