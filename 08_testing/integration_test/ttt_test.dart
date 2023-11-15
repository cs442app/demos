import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/views/ttt_game.dart';

void main() {
  group('Testing Tic-Tac-Toe app', () {
    testWidgets('Simple moves', (tester) async {
      await tester.pumpWidget(const TTTApp());

      final moves = [
        'cell-0-0',
        'cell-0-1',
        'cell-0-2',
        'cell-1-0',
      ];

      for (var key in moves) {
        await tester.tap(find.byKey(ValueKey(key)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.close), findsNWidgets(2));
      expect(find.byIcon(Icons.circle_outlined), findsNWidgets(2));
    });

    testWidgets('Invalid (repeat) move', (tester) async {
      await tester.pumpWidget(const TTTApp());

      await tester.tap(find.byKey(const ValueKey('cell-0-0')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.byKey(const ValueKey('cell-0-0')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Cell is not playable.'), findsOneWidget);
    });

    testWidgets('Win (X)', (tester) async {
      await tester.pumpWidget(const TTTApp());

      final moves = [
        'cell-0-0',
        'cell-1-1',
        'cell-0-1',
        'cell-2-2',
        'cell-0-2',
      ];

      for (var key in moves) {
        await tester.tap(find.byKey(ValueKey(key)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      expect(find.text('Winner: X'), findsOneWidget);
    });

    testWidgets('Win (O)', (tester) async {
      await tester.pumpWidget(const TTTApp());

      final moves = [
        'cell-0-1',
        'cell-1-1',
        'cell-0-2',
        'cell-0-0',
        'cell-2-1',
        'cell-2-2',
      ];

      for (var key in moves) {
        await tester.tap(find.byKey(ValueKey(key)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      expect(find.text('Winner: O'), findsOneWidget);
    });

    testWidgets('Tie', (tester) async {
      await tester.pumpWidget(const TTTApp());

      final moves = [
        'cell-0-0',
        'cell-0-1',
        'cell-0-2',
        'cell-1-1',
        'cell-1-0',
        'cell-1-2',
        'cell-2-1',
        'cell-2-0',
        'cell-2-2',
      ];

      for (var key in moves) {
        await tester.tap(find.byKey(ValueKey(key)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      expect(find.text('Tie'), findsOneWidget);
    });
  });
}
