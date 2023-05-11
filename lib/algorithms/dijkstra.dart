import '../data_structures/graph/graph.dart';
import '../data_structures/queue/priority_queue.dart';

class VertexDistance<Element> extends Comparable<VertexDistance<Element>> {
  VertexDistance(this.distance, [this.vertex]);

  final double distance;
  final Vertex<Element>? vertex;

  @override
  int compareTo(VertexDistance<Element> other) {
    return distance.compareTo(other.distance);
  }

  @override
  String toString() => '($vertex, $distance)';
}

class Dijkstra<Element> {
  Dijkstra(this.graph);

  final GraphInterface<Element> graph;

  Map<Vertex<Element>, VertexDistance<Element>?> shortestPathsOf(
    Vertex<Element> source,
  ) {
    final queue = PriorityQueue<VertexDistance<Element>>.min();
    final visited = <Vertex<Element>>{};
    final paths = <Vertex<Element>, VertexDistance<Element>?>{};

    for (final vertex in graph.vertices) {
      paths[vertex] = null;
    }

    queue.enqueue(VertexDistance(0, source));
    paths[source] = VertexDistance(0);
    visited.add(source);

    while (!queue.isEmpty) {
      final current = queue.dequeue();
      final savedDistance = paths[current.vertex]!.distance;
      if (current.distance > savedDistance) {
        continue;
      }

      visited.add(current.vertex!);

      for (final edge in graph.edgesOf(current.vertex!) ?? <Edge<Element>>[]) {
        final neighbor = edge.destination;
        if (visited.contains(neighbor)) {
          continue;
        }

        final weight = edge.weight ?? double.infinity;
        final totalDistance = current.distance + weight;
        final knownDistance = paths[neighbor]?.distance ?? double.infinity;
        if (totalDistance < knownDistance) {
          paths[neighbor] = VertexDistance(totalDistance, current.vertex);
          queue.enqueue(VertexDistance(totalDistance, neighbor));
        }
      }
    }

    return paths;
  }
}
