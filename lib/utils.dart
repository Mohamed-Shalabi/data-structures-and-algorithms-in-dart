extension ListElementSwapper<Element> on List<Element> {
  void swap(int indexA, int indexB) {
    final temp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = temp;
  }
}

extension ListMedianGetter<Element extends Comparable<Element>>
    on List<Element> {
  int medianOfThree(
    int low,
    int high,
  ) {
    final center = (low + high) ~/ 2;
    if (this[low].compareTo(this[center]) > 0) {
      swap(low, center);
    }
    if (this[low].compareTo(this[high]) > 0) {
      swap(low, high);
    }
    if (this[center].compareTo(this[high]) > 0) {
      swap(center, high);
    }
    return center;
  }
}
