import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firestore_todos/blocs/blocs.dart';
import 'package:test/test.dart';

List<String> printLog;
void main() {
  group('SimpleBlocDelegate', () {
    SimpleBlocDelegate delegate;

    setUp(() {
      delegate = SimpleBlocDelegate();
      printLog = <String>[];
    });

    test('onTransition prints Transition', overridePrint(() {
      delegate.onTransition(
        null,
        Transition<String, String>(
          currentState: 'A',
          event: 'E',
          nextState: 'B',
        ),
      );
      expect(
        printLog[0],
        'Transition { currentState: A, event: E, nextState: B }',
      );
    }));

    test('onError prints Error', overridePrint(() {
      delegate.onError(null, 'whoops', null);
      expect(
        printLog[0],
        'whoops',
      );
    }));

    test('onEvent prints Event', overridePrint(() {
      delegate.onError(null, 'event', null);
      expect(
        printLog[0],
        'event',
      );
    }));
  });
}

dynamic overridePrint(dynamic testFn()) => () {
      var spec = ZoneSpecification(print: (_, __, ___, String msg) {
        // Add to log instead of printing to stdout
        printLog.add(msg);
      });
      return Zone.current.fork(specification: spec).run<dynamic>(testFn);
    };
