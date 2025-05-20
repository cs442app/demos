import 'package:test/test.dart';
import 'package:testing_demo/models/favorites.dart';

void main() {
  group('Testing Favorites model', () {
    var favorites = Favorites();

    test('A new item should be added', () {
      var number = 35;
      favorites.add(number);
      expect(favorites.items.contains(40), true);
    });
  });
}
