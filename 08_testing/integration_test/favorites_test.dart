import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/views/fav_home.dart';

void main() {
  group('Testing App', () {
    testWidgets('Favorites operations test', (tester) async {
      await tester.pumpWidget(const FavoritesApp());

      final iconKeys = [
        'icon_0',
        'icon_1',
        'icon_2',
      ];

      for (var icon in iconKeys) {
        await tester.tap(find.byKey(ValueKey(icon)));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('Added to favorites.'), findsOneWidget);
      }

      await tester.tap(find.byKey(const ValueKey('Favorites')));
      await tester.pumpAndSettle();

      final removeIconKeys = [
        'remove_icon_0',
        'remove_icon_1',
        'remove_icon_2',
      ];

      for (final iconKey in removeIconKeys) {
        await tester.tap(find.byKey(ValueKey(iconKey)));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('Removed from favorites.'), findsOneWidget);
      }
    });
  });

  group('Long scrolling test', () {
    testWidgets('Scroll to bottom', (tester) async {
      await tester.pumpWidget(const FavoritesApp());

      await tester.dragUntilVisible(
        find.text('Item 99'),
        find.byType(ListView),
        const Offset(0, -500)
      );

      expect(find.text('Item 99'), findsOneWidget);
    });
  });
}
