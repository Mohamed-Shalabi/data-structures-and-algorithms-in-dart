import 'package:dart_dsa/data_structures/queue/queue_list.dart';

import '../../data_structures/graph/graph.dart';
import '../../data_structures/queue/queue_interface.dart';
import '../../data_structures/stack/stack.dart';

extension GraphCycleChecker<Element> on GraphInterface<Element> {
  bool hasCycle(Vertex<Element> source) {
    Set<Vertex<Element>> pushed = {};
    return _hasCycle(source, pushed);
  }

  bool _hasCycle(Vertex<Element> source, Set<Vertex<Element>> pushed) {
    pushed.add(source);
    final neighbors = edgesOf(source) ?? [];

    for (final edge in neighbors) {
      if (!pushed.contains(edge.destination)) {
        if (_hasCycle(edge.destination, pushed)) {
          return true;
        }
      } else {
        return true;
      }
    }

    pushed.remove(source);

    return false;
  }
}

extension GraphDepthFirstSearch<Element> on GraphInterface<Element> {
  List<Vertex<Element>> recursiveDepthFirstSearch(
    Vertex<Element> source, {
    void Function(Vertex<Element>)? action,
  }) {
    final queue = QueueListImpl<Vertex<Element>>();
    final Set<Vertex<Element>> enqueued = {};
    List<Vertex<Element>> result = [];

    queue.enqueue(source);
    enqueued.add(source);

    _recursiveDepthFirstSearch(
      queue,
      enqueued,
      result,
      action: action,
    );

    return result;
  }

  void _recursiveDepthFirstSearch(
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

    _recursiveDepthFirstSearch(
      queue,
      enqueued,
      visited,
      action: action,
    );
  }

  List<Vertex<Element>> depthFirstSearch(
    Vertex<Element> source, {
    void Function(Vertex<Element>)? action,
  }) {
    final visitedVertices = <Vertex<Element>>[];
    final stacked = <Vertex<Element>>{};
    final stack = Stack<Vertex<Element>>.empty();

    stack.push(source);
    stacked.add(source);
    while (!stack.isEmpty) {
      final vertex = stack.pop();
      action?.call(vertex);
      visitedVertices.add(vertex);
      final neighborEdges = edgesOf(vertex);

      for (final edge in neighborEdges ?? <Edge<Element>>[]) {
        if (!stacked.contains(edge.destination)) {
          final destination = edge.destination;
          stack.push(destination);
          stacked.add(destination);
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
  graph.addEdge(source: c, destination: g, weight: 1);
  graph.addEdge(source: e, destination: f, weight: 1);
  graph.addEdge(source: e, destination: h, weight: 1);
  graph.addEdge(source: e, destination: f, weight: 1);
  graph.addEdge(source: f, destination: g, weight: 1);

  print(graph.depthFirstSearch(a, action: print));
}
