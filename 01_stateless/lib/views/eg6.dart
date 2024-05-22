/* Demonstrates some complex nested widgets, and a 
 * separation of model (data) & widget (view) code.
 */

import 'package:flutter/Material.dart';

class App6 extends StatelessWidget {
  const App6({super.key});

  @override
  Widget build(BuildContext context) {
    const foods = {
      FavoriteItem(
        name: 'Pizza',
        description: 'A delicious pie of cheese and sauce',
        imagePath: 'assets/images/pizza.jpg'
      ),
      FavoriteItem(
        name: 'Burger',
        description: 'A juicy burger with all the fixings',
        imagePath: 'assets/images/burger.jpg'
      ),
      FavoriteItem(
        name: 'Ice Cream',
        description: 'A sweet treat to cool you down',
        imagePath: 'assets/images/ice_cream.jpg'
      ),
    };

    const languages = {
      FavoriteItem(
        name: 'Haskell',
        description: 'A purely functional programming language',
        imagePath: 'assets/images/haskell.png'
      ),
      FavoriteItem(
        name: 'Lisp',
        description: 'Lots of irritating superfluous parentheses',
        imagePath: 'assets/images/lisp.png'
      ),
      FavoriteItem(
        name: 'Rust',
        description: 'A systems programming language',
        imagePath: 'assets/images/rust.png'
      ),
    };

    // can you spot the nested `Row` and `Column` widgets?
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite Things'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foods', 
            style: Theme.of(context).textTheme.headlineLarge
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: foods.map((item) => FavoriteWidget(item: item)).toList(),
          ),
          const SizedBox(height: 30),
          Text(
            'Languages', 
            style: Theme.of(context).textTheme.headlineLarge
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: languages.map((item) => FavoriteWidget(item: item)).toList(),
          ),
        ],
      )
    );
  }
}


class FavoriteItem {
  final String name;
  final String description;
  final String imagePath;

  const FavoriteItem({
    required this.name,
    required this.description,
    required this.imagePath,
  });
}


class FavoriteWidget extends StatelessWidget {
  final FavoriteItem item;

  const FavoriteWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          GestureDetector(
            child: Image.asset(
              item.imagePath,
              width: 100,
              height: 100,
            ),
            onTap: () => _showSnackBar(context, item.description)
          ),
          const SizedBox(height: 8),
          Text(
            item.name,
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }

  // a "Snackbar" is a Material widget that appears at the bottom of the screen
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 500),
      )
    );
  }
}
