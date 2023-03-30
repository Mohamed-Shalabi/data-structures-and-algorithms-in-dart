import 'package:dart_dsa/utils.dart';

extension SelectionSort<Element extends Comparable<Element>> on List<Element> {
  void selectionSort() {
    for (var startIndex = 0; startIndex < length; startIndex++) {
      var lowestIndex = startIndex;

      for (var currentIndex = startIndex + 1;
          currentIndex < length;
          currentIndex++) {
        var lowestElement = this[lowestIndex];
        var currentElement = this[currentIndex];
        if (currentElement.compareTo(lowestElement) < 0) {
          lowestIndex = currentIndex;
        }
      }

      if (lowestIndex != startIndex) {
        swap(lowestIndex, startIndex);
      }
    }
  }
}

void main() {
  final list = <num>[9, 4, 10, 3];
  print('Original: $list');
  list.selectionSort();
  print('Selection sorted: $list');
}
