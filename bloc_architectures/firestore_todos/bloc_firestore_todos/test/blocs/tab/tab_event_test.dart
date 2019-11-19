// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:bloc_firestore_todos/blocs/blocs.dart';
import 'package:bloc_firestore_todos/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TabEvent', () {
    group('UpdateTab', () {
      test('toString returns correct value', () {
        expect(
          UpdateTab(AppTab.todos).toString(),
          'UpdateTab { tab: AppTab.todos }',
        );
      });
    });
  });
}
