import 'package:bloc_firestore_todos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadingIndicator', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      final loadingIndicatorKey = Key('loading_indicator_key');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingIndicator(
              key: loadingIndicatorKey,
            ),
          ),
        ),
      );
      expect(find.byKey(loadingIndicatorKey), findsOneWidget);
    });
  });
}
