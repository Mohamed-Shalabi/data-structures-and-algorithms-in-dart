import 'dart:math';

extension InserionSort<Element extends Comparable<Element>> on List<Element> {
  void insertionSort() {
    for (var i = 0; i < length; i++) {
      if (i > 0 && this[i].compareTo(this[i - 1]) < 0) {
        for (var j = i - 1; j >= 0; j--) {
          if (this[i].compareTo(this[j]) >= 0 || j == 0) {
            insert(j, removeAt(i));
            break;
          }
        }
      }
    }
  }
}

void main() {
  var list = <num>[
    9,
    4,
    10,
    3,
    22,
    12,
    8,
    2,
    3,
    1,
    0,
    -4,
    for (var i = 23; i < 99; i++) i * pow(-1, i),
  ];
  print('Original: $list');
  list.insertionSort();
  print('sorted: $list');
}
