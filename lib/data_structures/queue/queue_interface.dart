abstract class QueueInterface<Element> {
  bool enqueue(Element element);
  Element dequeue();
  bool get isEmpty;
  Element get peek;
}

abstract class QueueException with Exception {
  QueueException(this.message);
  final String message;
}

class PeekingEmptyQueueException extends QueueException {
  PeekingEmptyQueueException(): super('tried to peak an empty queue');
}

class DequeuingEmptyQueueException extends QueueException {
  DequeuingEmptyQueueException(): super('tried to pop an empty queue');
}
