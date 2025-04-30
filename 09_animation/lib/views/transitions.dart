import 'package:flutter/material.dart';

class TransitionDemo extends StatelessWidget {
  const TransitionDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/scarlet-hawks.png',
              width: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_buildPageRoute());
              },
              child: const Text('Next'),
            ),
          ],
        ),
      );
  }
}

PageRouteBuilder _buildPageRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation)  => const Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return RotationTransition(
        turns: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.asset(
          'assets/images/scarlet-hawks.png',
          width: 100,
        ),
      ),
    );
  }
}
