import 'dart:math';

List<Element> mergeSort<Element extends Comparable<Element>>(List<Element> list) {
  if (list.length < 2) return list;

  final middle = list.length ~/ 2;
  final left = mergeSort(list.sublist(0, middle));
  final right = mergeSort(list.sublist(middle));

  return left._merge(right);
}

extension _Merger<Element extends Comparable<Element>> on List<Element> {
  List<Element> _merge(List<Element> other) {
    var indexA = 0;
    var indexB = 0;
    final result = <Element>[];

    while (indexA < length && indexB < other.length) {
      final valueA = this[indexA];
      final valueB = other[indexB];
      if (valueA.compareTo(valueB) < 0) {
        result.add(valueA);
        indexA += 1;
      } else if (valueA.compareTo(valueB) > 0) {
        result.add(valueB);
        indexB += 1;
      } else {
        result.add(valueA);
        result.add(valueB);
        indexA += 1;
        indexB += 1;
      }
    }

    if (indexA < length) {
      result.addAll(getRange(indexA, length));
    }

    if (indexB < other.length) {
      result.addAll(other.getRange(indexB, other.length));
    }

    return result;
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
  mergeSort(list);
  print('sorted: $list');
}
