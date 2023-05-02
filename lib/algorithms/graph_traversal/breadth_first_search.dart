import 'package:dart_dsa/data_structures/queue/queue_list.dart';

import '../../data_structures/graph/graph.dart';
import '../../data_structures/queue/queue_interface.dart';

extension GraphDisconnectionChecker<Element> on GraphInterface<Element> {
  bool get isConnected {
    if (vertices.isEmpty) {
      return true;
    }

    bool result = true;
    final start = vertices.first;
    breadthFirstSearch(
      start,
      action: (vertex) {
        if (edgesOf(vertex)?.isEmpty ?? false) {
          result = false;
        }
      },
    );

    return result;
  }
}

extension GraphBreadthFirstSearch<Element> on GraphInterface<Element> {
  List<Vertex<Element>> recursiveBreadthFirstSearch(
    Vertex<Element> source, {
    void Function(Vertex<Element>)? action,
  }) {
    final queue = QueueListImpl<Vertex<Element>>();
    final Set<Vertex<Element>> enqueued = {};
    List<Vertex<Element>> result = [];

    queue.enqueue(source);
    enqueued.add(source);

    _recursiveBreadthFirstSearch(
      queue,
      enqueued,
      result,
      action: action,
    );

    return result;
  }

  void _recursiveBreadthFirstSearch(
    QueueInterface<Vertex<Element>> queue,
    Set<Vertex<Element>> enqueued,
    List<Vertex<Element>> visited, {
    required void Function(Vertex<Element>)? action,
  }) {
    if (queue.isEmpty) {
      return;
    }

    final vertex = queue.dequeue();
    visited.add(vertex);
    action?.call(vertex);
    final neighbouringEdges = edgesOf(vertex) ?? [];

    for (final edge in neighbouringEdges) {
      final destination = edge.destination;
      if (!enqueued.contains(destination)) {
        queue.enqueue(destination);
        enqueued.add(destination);
      }
    }

    _recursiveBreadthFirstSearch(
      queue,
      enqueued,
      visited,
      action: action,
    );
  }

  List<Vertex<Element>> breadthFirstSearch(
    Vertex<Element> source, {
    void Function(Vertex<Element>)? action,
  }) {
    action?.call(source);

    final visitedVertices = <Vertex<Element>>[];
    final enqueued = <Vertex<Element>>{};
    final queue = QueueListImpl<Vertex<Element>>();

    queue.enqueue(source);
    enqueued.add(source);
    while (!queue.isEmpty) {
      final vertex = queue.dequeue();
      visitedVertices.add(vertex);
      final neighborEdges = edgesOf(vertex);

      for (final edge in neighborEdges ?? <Edge<Element>>[]) {
        if (!enqueued.contains(edge.destination)) {
          final destination = edge.destination;
          queue.enqueue(destination);
          enqueued.add(destination);
          action?.call(destination);
        }
      }
    }

    return visitedVertices;
  }
}

void main() {
  final graph = AdjacencyList<String>();
  final a = graph.createVertex('A');
  final b = graph.createVertex('B');
  final c = graph.createVertex('C');
  final d = graph.createVertex('D');
  final e = graph.createVertex('E');
  final f = graph.createVertex('F');
  final g = graph.createVertex('G');
  final h = graph.createVertex('H');
  graph.addEdge(source: a, destination: b, weight: 1);
  graph.addEdge(source: a, destination: c, weight: 1);
  graph.addEdge(source: a, destination: d, weight: 1);
  graph.addEdge(source: b, destination: e, weight: 1);
  graph.addEdge(source: c, destination: f, weight: 1);
  graph.addEdge(source: c, destination: g, weight: 1);
  graph.addEdge(source: e, destination: h, weight: 1);
  graph.addEdge(source: e, destination: f, weight: 1);
  graph.addEdge(source: f, destination: g, weight: 1);

  graph.recursiveBreadthFirstSearch(a, action: print);
}
