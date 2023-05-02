part of 'graph.dart';

class AdjacencyMatrix<Element> implements GraphInterface<Element> {
  final _vertices = <Vertex<Element>>[];
  final _weights = <List<double?>>[];
  var _nextIndex = 0;

  @override
  void addEdge({
    required Vertex<Element> source,
    required Vertex<Element> destination,
    required double? weight,
    EdgeType edgeType = EdgeType.undirected,
  }) {
    _weights[source.index][destination.index] = weight;
    if (edgeType == EdgeType.undirected) {
      _weights[destination.index][source.index] = weight;
    }
  }

  @override
  Vertex<Element> createVertex(Element data) {
    final vertex = Vertex(
      index: _nextIndex,
      data: data,
    );
    _nextIndex++;
    _vertices.add(vertex);

    for (var i = 0; i < _weights.length; i++) {
      _weights[i].add(null);
    }

    final row = List<double?>.filled(
      _vertices.length,
      null,
      growable: true,
    );
    _weights.add(row);

    return vertex;
  }

  @override
  List<Edge<Element>>? edgesOf(Vertex<Element> source) {
    List<Edge<Element>> edges = [];

    for (var column = 0; column < _weights.length; column++) {
      final weight = _weights[source.index][column];
      if (weight == null) {
        continue;
      }

      final destination = _vertices[column];
      edges.add(Edge(source, destination, weight));
    }

    return edges;
  }

  @override
  double? getWeightBetween(
    Vertex<Element> source,
    Vertex<Element> destination,
  ) {
    return _weights[source.index][destination.index];
  }

  @override
  Iterable<Vertex<Element>> get vertices => _vertices;

  @override
  String toString() {
    final output = StringBuffer();

    for (final vertex in _vertices) {
      output.writeln('${vertex.index}: ${vertex.data}');
    }

    for (int i = 0; i < _weights.length; i++) {
      for (int j = 0; j < _weights.length; j++) {
        final value = (_weights[i][j] ?? '.').toString();
        output.write(value.padRight(6));
      }
      output.writeln();
    }

    return output.toString();
  }
}

void main() {
  final graph = AdjacencyMatrix<String>();
  final singapore = graph.createVertex('Singapore');
  final tokyo = graph.createVertex('Tokyo');
  final hongKong = graph.createVertex('Hong Kong');
  final detroit = graph.createVertex('Detroit');
  final sanFrancisco = graph.createVertex('San Francisco');
  final washingtonDC = graph.createVertex('Washington DC');
  final austinTexas = graph.createVertex('Austin Texas');
  final seattle = graph.createVertex('Seattle');
  graph.addEdge(source: singapore, destination: hongKong, weight: 300);
  graph.addEdge(source: singapore, destination: tokyo, weight: 500);
  graph.addEdge(source: hongKong, destination: tokyo, weight: 250);
  graph.addEdge(source: tokyo, destination: detroit, weight: 450);
  graph.addEdge(source: tokyo, destination: washingtonDC, weight: 300);
  graph.addEdge(source: hongKong, destination: sanFrancisco, weight: 600);
  graph.addEdge(source: detroit, destination: austinTexas, weight: 50);
  graph.addEdge(source: austinTexas, destination: washingtonDC, weight: 292);
  graph.addEdge(source: sanFrancisco, destination: washingtonDC, weight: 337);
  graph.addEdge(source: washingtonDC, destination: seattle, weight: 277);
  graph.addEdge(source: sanFrancisco, destination: seattle, weight: 218);
  graph.addEdge(source: austinTexas, destination: sanFrancisco, weight: 297);
  print(graph);
}
