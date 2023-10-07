/* Play with some more child widgets and options */

import 'package:flutter/Material.dart';

class App2 extends StatelessWidget {
  const App2({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // the following property is inherited by descendant widgets
      textDirection: TextDirection.ltr,
      child: Column(
        // try to tweak this property in the layout explorer
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Hello!'), // no need to specify `textDirection` here
          const SizedBox(height: 50, width: 50), // spacer
          GestureDetector(
            child: const Text(
              'World!',
              style: TextStyle( // manually specified fancy style
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 30
              )
            ),
            // callback for when the widget is tapped
            onTap: () => print('"World!" clicked'),
          ),
        ]
      ),
    );
  }      
}
