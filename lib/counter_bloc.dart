import 'dart:async';

import 'package:bloc_without_bloc/counter_event.dart';

class CounterBloc {
  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  int _counter = 0;

  final StreamController<int> _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink;

  Stream<int> get counter => _counterStateController.stream;

  final StreamController<CounterEvent> _counterEventController =
      StreamController<CounterEvent>();

  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
