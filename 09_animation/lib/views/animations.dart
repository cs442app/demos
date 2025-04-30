// ignore_for_file: sized_box_for_whitespace
import 'package:flutter/material.dart';

class ImplicitAnimations extends StatefulWidget {
  const ImplicitAnimations({super.key});

  @override
  State<ImplicitAnimations> createState() => _ImplicitAnimationsState();
}

class _ImplicitAnimationsState extends State<ImplicitAnimations> {
  bool _animToggle = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _animToggle = !_animToggle;
        });
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // standard container
                  Container(
                    width: _animToggle ? 100 : 50,
                    height: _animToggle ? 100 : 50,
                    child: Image.asset('assets/images/scarlet-hawks.png'),
                  ),
                  // animated container
                  AnimatedContainer(
                    // animation duration
                    duration: const Duration(milliseconds: 500),
                    // animation interpolation curve (try some others)
                    curve: Curves.ease,
                    width: _animToggle ? 100 : 50,
                    height: _animToggle ? 100 : 50,
                    child: Image.asset('assets/images/scarlet-hawks.png'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // standard opacity
                  Opacity(
                    opacity: _animToggle ? 1.0 : 0.0, 
                    child: Image.asset(
                      'assets/images/scarlet-hawks.png',
                      width: 100,
                    )
                  ),
                  // animated opacity
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _animToggle ? 1.0 : 0.0,
                    child: Image.asset(
                      'assets/images/scarlet-hawks.png',
                      width: 100,
                    )
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    width: 300,
                    height: 100,
                  ),
                  // standard position
                  Positioned(
                    top: _animToggle ? 0 : 50,
                    left: _animToggle ? 0 : 250,
                    child: Image.asset(
                      'assets/images/scarlet-hawks.png',
                      width: 50,
                    )
                  ),
                  // animated position
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    top: _animToggle ? 0 : 50,
                    left: _animToggle ? 250 : 0,
                    child: Image.asset(
                      'assets/images/scarlet-hawks.png',
                      width: 50,
                    )
                  )
                ]
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // standard switcher
                  (_animToggle 
                    ? Image.asset(
                        'assets/images/scarlet-hawks.png',
                        width: 100
                      )
                    : Image.asset(
                        'assets/images/iit.png',
                        width: 100
                      )
                  ),
                  // animated switcher
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: _animToggle 
                      ? Image.asset(
                          key: const ValueKey(1),
                          'assets/images/scarlet-hawks.png',
                          width: 100
                        )
                      : Image.asset(
                          key: const ValueKey(2),
                          'assets/images/iit.png',
                          width: 100
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
