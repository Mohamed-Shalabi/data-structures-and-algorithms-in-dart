extension BinarySearch<Element extends Comparable<Element>> on List<Element> {
  int? binarySearch(Element value, [int? start, int? end]) {
    final endBarrier = end ?? length;
    start ??= 0;
    end ??= length - 1;
    final pivot = (start + endBarrier) ~/ 2;

    if (start > end) {
      return null;
    }

    final currentValue = this[pivot];
    if (value == currentValue) {
      return pivot;
    }

    if (value.compareTo(currentValue) < 0) {
      return binarySearch(value, start, pivot);
    }

    return binarySearch(value, pivot, endBarrier);
  }
}

void main() {
  final list = <num>[1, 5, 15, 17, 19, 22, 24, 31, 105, 150];
  final searchTerm = 1;
  final search31 = list.indexOf(searchTerm);
  final binarySearch31 = list.binarySearch(searchTerm);
  print('indexOf: $search31');
  print('binarySearch: $binarySearch31');
}
