import 'dart:async';

/// Simple app-wide bus for domain events. Blocs (or use cases) fire events;
/// subscribers (analytics, logging, etc.) listen and react without bloc knowing.
class EventBus {
  final _controller = StreamController<Object>.broadcast(sync: true);

  void fire(Object event) {
    _controller.add(event);
  }

  Stream<T> on<T>() => _controller.stream.where((e) => e is T).cast<T>();

  void dispose() {
    _controller.close();
  }
}
