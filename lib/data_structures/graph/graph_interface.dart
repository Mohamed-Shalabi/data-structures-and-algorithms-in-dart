part of 'graph.dart';

enum EdgeType { directed, undirected }

abstract class GraphInterface<Element> {
  Iterable<Vertex<Element>> get vertices;

  void addEdge({
    required Vertex<Element> source,
    required Vertex<Element> destination,
    required double? weight,
    EdgeType edgeType = EdgeType.undirected,
  });

  Vertex<Element> createVertex(Element data);

  List<Edge<Element>>? edgesOf(Vertex<Element> source);

  double? getWeightBetween(
    Vertex<Element> source,
    Vertex<Element> destination,
  );
}
