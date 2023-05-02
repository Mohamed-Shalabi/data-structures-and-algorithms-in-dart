part of 'graph.dart';

class Edge<Element> {
  final Vertex<Element> source;
  final Vertex<Element> destination;
  final double? weight;

  const Edge(
    this.source,
    this.destination, [
    this.weight,
  ]);
}

class Vertex<Element> {
  final int index;
  final Element data;

  const Vertex({
    required this.index,
    required this.data,
  });

  @override
  String toString() => data.toString();
}
