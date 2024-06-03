/* Topics demonstrated:
 * - Passing data to the second page
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
                Navigator.push(
                  context,
                  MaterialPageRoute<String>(
                    builder: (context) {
                      // Pass the chosen question to the next page
                      return DecisionPage(questions[index]);
                    }
                  ),
                );
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
                    Navigator.pop(context);
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
