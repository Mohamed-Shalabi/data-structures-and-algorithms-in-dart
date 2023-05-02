part of 'graph.dart';

class AdjacencyList<Element> implements GraphInterface<Element> {
  final Map<Vertex<Element>, List<Edge<Element>>> _connections = {};
  var _nextIndex = 0;

  @override
  void addEdge({
    required Vertex<Element> source,
    required Vertex<Element> destination,
    required double? weight,
    EdgeType edgeType = EdgeType.undirected,
  }) {
    edgesOf(source)?.add(
      Edge(
        source,
        destination,
        weight,
      ),
    );

    if (edgeType == EdgeType.undirected) {
      edgesOf(destination)?.add(
        Edge(
          destination,
          source,
          weight,
        ),
      );
    }
  }

  @override
  Vertex<Element> createVertex(Element data) {
    final vertex = Vertex(
      index: _nextIndex,
      data: data,
    );

    _nextIndex++;

    _connections[vertex] = [];
    return vertex;
  }

  @override
  List<Edge<Element>>? edgesOf(Vertex<Element> source) {
    return _connections[source];
  }

  @override
  double? getWeightBetween(
    Vertex<Element> source,
    Vertex<Element> destination,
  ) {
    final match = edgesOf(source)?.where((edge) {
      return edge.destination == destination;
    });

    if (match == null || match.isEmpty) {
      return null;
    }

    return match.first.weight;
  }

  @override
  Iterable<Vertex<Element>> get vertices => _connections.keys;

  @override
  String toString() {
    final result = StringBuffer();

    _connections.forEach((vertex, edges) {
      final destinations = edges.map((edge) {
        return edge.destination;
      }).join(', ');

      result.writeln('$vertex --> $destinations');
    });

    return result.toString();
  }
}
