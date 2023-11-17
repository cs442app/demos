import 'package:flutter/material.dart';

class HeroPage1 extends StatelessWidget {
  const HeroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Hero widget
            Hero(
              tag: 'imageHero',
              child: Image.asset(
                'assets/images/scarlet-hawks.png',
                width: 100,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HeroPage2(),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      );
  }
}

class HeroPage2 extends StatelessWidget {
  const HeroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Page 2'),
      ),
      body: Center(
        // Hero widget
        child: Hero(
          tag: 'imageHero',
          child: Image.asset(
            'assets/images/scarlet-hawks.png',
            width: 200,            
          ),
        ),
      ),
    );
  }
}
