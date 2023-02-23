import 'package:meta/meta.dart';

abstract class RingBuffer<Element> {
  RingBuffer({
    required this.size,
  }) : _list = List.generate(size, (_) => null);

  final List<Element?> _list;
  final int size;
  int _readIndex = 0;
  int _writeIndex = 0;

  @nonVirtual
  bool get isEmptyRingBuffer =>
      _readIndex == _writeIndex - 1 ||
      _readIndex == size - 1 && _writeIndex == 0;

  @nonVirtual
  void _incrementReadIndex() {
    var temp = _readIndex;
    _readIndex += 1;
    if (_readIndex == size) {
      _readIndex = 0;
    }

    if (_readIndex == _writeIndex || _list[_readIndex] == null) {
      _readIndex = temp;
      throw RingBufferExceededSizeException(
        writeIndex: _writeIndex,
        readIndex: _readIndex,
        );
    }
  }

  @nonVirtual
  void _incrementWriteIndex() {
    _writeIndex += 1;
    if (_writeIndex == size) {
      _writeIndex = 0;
    }

    if (_writeIndex == _readIndex + 1 ||
        _readIndex == 0 && _writeIndex == size - 1) {
      _readIndex = _writeIndex - 1;
      if (_readIndex == -1) {
        _readIndex = size - 1;
      }
    }
  }

  @nonVirtual
  void addElement(Element element) {
    _list[_writeIndex] = element;
    _incrementWriteIndex();
  }

  @nonVirtual
  Element currentElement() {
    return _list[_readIndex]!;
  }

  @nonVirtual
  Element popElement() {
    final result = _list[_readIndex] as Element;
    _list[_readIndex] = null;
    _incrementReadIndex();
    return result;
  }

  @override
  String toString() {
    return '''#################
        ${_list.toString()}
        read index: $_readIndex
        write index: $_writeIndex
#################''';
  }
}

abstract class RingBufferException with Exception {
  RingBufferException(this.message);

  final String message;

  @override
  String toString() => message;
}

class RingBufferExceededSizeException extends RingBufferException {
  RingBufferExceededSizeException({
    required this.readIndex,
    required this.writeIndex,
  }) : super('No more space in the RingBuffer, read index = $readIndex, write index = $writeIndex');

  final int writeIndex;
  final int readIndex;
}
