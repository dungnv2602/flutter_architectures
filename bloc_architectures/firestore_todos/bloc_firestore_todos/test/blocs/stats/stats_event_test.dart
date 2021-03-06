// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:bloc_firestore_todos/blocs/blocs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StatsEvent', () {
    group('UpdateStats', () {
      test('toString returns correct value', () {
        expect(
          UpdateStats([]).toString(),
          'UpdateStats { todos: [] }',
        );
      });
    });
  });
}
