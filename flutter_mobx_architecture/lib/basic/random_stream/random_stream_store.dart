import 'dart:async';
import 'dart:math';

import 'package:mobx/mobx.dart';

part 'random_stream_store.g.dart';

final _random = Random();

class RandomStreamStore = _RandomStreamStore with _$RandomStreamStore;

abstract class _RandomStreamStore with Store {
  _RandomStreamStore() {
    _streamController = StreamController<int>();

    _timer = Timer.periodic(Duration(seconds: 1), (_) => _streamController.add(_random.nextInt(100)));

    randomStream = ObservableStream(_streamController.stream);
  }

  ObservableStream<int> randomStream;

  Timer _timer;
  StreamController<int> _streamController;

  @override
  void dispose() async {
    _timer.cancel();
    await _streamController.close();
    super.dispose();
  }
}
