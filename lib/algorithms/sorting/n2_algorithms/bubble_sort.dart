import 'package:dart_dsa/utils.dart';

extension BubbleSort<Element extends Comparable<Element>> on List<Element> {
  void bubbleSort() {
    for (var i = 0; i < length; i++) {
      var isSwapped = false;
      for (var j = 0; j < length; j++) {
        if (this[i].compareTo(this[j]) > 0) {
          swap(i, j);
          isSwapped = true;
        }
      }

      if (!isSwapped) {
        return;
      }
    }
  }
}
