import 'package:dart_dsa/utils.dart';

List<Element> quickSortNaive<Element extends Comparable<Element>>(
  List<Element> list,
) {
  if (list.length < 2) {
    return list;
  }

  final pivot = list[0];

  final less = list
      .where(
        (value) => value.compareTo(pivot) < 0,
      )
      .toList();

  final equal = list
      .where(
        (value) => value.compareTo(pivot) == 0,
      )
      .toList();

  final greater = list
      .where(
        (value) => value.compareTo(pivot) > 0,
      )
      .toList();

  return [
    ...quickSortNaive(less),
    ...equal,
    ...quickSortNaive(greater),
  ];
}

void quicksortLomuto<Element extends Comparable<Element>>(
  List<Element> list,
  int low,
  int high,
) {
  if (low >= high) {
    return;
  }

  final pivotIndex = _partitionLomuto(list, low, high);

  quicksortLomuto(list, low, pivotIndex - 1);
  quicksortLomuto(list, pivotIndex + 1, high);
}

void quicksortHoare<Element extends Comparable<Element>>(
  List<Element> list,
  int low,
  int high,
) {
  if (low >= high) {
    return;
  }

  final leftHigh = _partitionHoare(list, low, high);

  quicksortHoare(list, low, leftHigh);
  quicksortHoare(list, leftHigh + 1, high);
}

void quicksortMedian<Element extends Comparable<Element>>(
  List<Element> list,
  int low,
  int high,
) {
  if (low >= high) {
    return;
  }

  var pivotIndex = list.medianOfThree(low, high);
  list.swap(pivotIndex, high);
  pivotIndex = _partitionLomuto(list, low, high);

  quicksortLomuto(list, low, pivotIndex - 1);
  quicksortLomuto(list, pivotIndex + 1, high);
}

void quicksortDutchFlag<E extends Comparable<dynamic>>(
  List<E> list,
  int low,
  int high,
) {
  if (low >= high) {
    return;
  }

  final middle = _partitionDutchFlag(list, low, high);

  quicksortDutchFlag(list, low, middle.low - 1);
  quicksortDutchFlag(list, middle.high + 1, high);
}

class Range {
  const Range(this.low, this.high);
  final int low;
  final int high;
}

Range _partitionDutchFlag<T extends Comparable<dynamic>>(
  List<T> list,
  int low,
  int high,
) {
// 1
  final pivot = list[high];
// 2
  var smaller = low;
  var equal = low;
  var larger = high;
  while (equal <= larger) {
// 3
    if (list[equal].compareTo(pivot) < 0) {
      list.swap(smaller, equal);
      smaller += 1;
      equal += 1;
    } else if (list[equal] == pivot) {
      equal += 1;
    } else {
      list.swap(equal, larger);
      larger -= 1;
    }
  }
  return Range(smaller, larger);
}

int _partitionHoare<Element extends Comparable<Element>>(
  List<Element> list,
  int low,
  int high,
) {
  final pivot = list[low];
  var left = low - 1;
  var right = high + 1;
  while (true) {
    do {
      left += 1;
    } while (list[left].compareTo(pivot) < 0);

    do {
      right -= 1;
    } while (list[right].compareTo(pivot) > 0);

    if (left < right) {
      list.swap(left, right);
    } else {
      return right;
    }
  }
}

int _partitionLomuto<T extends Comparable<dynamic>>(
  List<T> list,
  int low,
  int high,
) {
  final pivot = list[high];
  var pivotIndex = low;

  for (int i = low; i < high; i++) {
    if (list[i].compareTo(pivot) <= 0) {
      list.swap(pivotIndex, i);
      pivotIndex += 1;
    }
  }

  list.swap(pivotIndex, high);

  return pivotIndex;
}
