/* Topics demonstrated:
 * - Passing data back and forth between two pages
 * - Asynchronous callbacks via `Future`
 * - Dealing with an "async gap"
 */

import 'package:flutter/material.dart';

class App2 extends StatelessWidget {
  const App2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App 2',
      home: QuestionPage(),
    );
  }
}

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    var questions = ['Stay home?', 'Go out?', 'Do work?'];

    return Scaffold(
      appBar: AppBar(title: const Text('Pick a question')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(questions.length, (index) {
            return TextButton(
              child: Text('${index + 1}'),
              onPressed: () {
                // `Navigator.push` returns a `Future` that completes when the
                // pushed page is popped off the navigation stack. The `Future`
                // contains the value (if any) passed to `Navigator.pop`
                Future<String?> result = Navigator.push(
                  context,
                  MaterialPageRoute<String>(
                    builder: (context) {
                      // Pass the chosen question to the next page
                      return DecisionPage(questions[index]);
                    }
                  ),
                );

                // Here we register a callback with the `Future` that will be
                // called when the `Future` completes. This can be written 
                // more prettily using `async`/`await` (see `eg3.dart`).
                result.then((String? value) {

                  // Since this runs after a delay (aka an "async gap"),
                  // we need to check that the page is still mounted before
                  // showing the `SnackBar` (otherwise the context is invalid, 
                  // and we get an error) --- this is a common pattern!
                  if (!context.mounted) return;

                  // Show a `SnackBar` with the result
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You chose: ${value ?? 'nothing'}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                });
              },
            );
          }).toList()
        ),
      )
    );
  }
}

class DecisionPage extends StatelessWidget {
  final String question;

  const DecisionPage(this.question, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Recall: the `AppBar` automatically provides a "back" button
      // -- what is returned to the `Future` if the user presses this?
      appBar: AppBar(title: const Text('Decide!')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(question, style: Theme.of(context).textTheme.headlineSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Yes', 'No', 'Maybe'].map((String answer) {
                return TextButton(
                  child: Text(answer),
                  onPressed: () {
                    // "Return" the answer to the previous page (this gets
                    // put in the `Future` returned by `Navigator.push`)
                    Navigator.pop(context, answer);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      )
    );
  }
}
