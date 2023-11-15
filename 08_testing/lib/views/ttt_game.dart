import 'package:flutter/material.dart';
import 'package:testing_demo/views/ttt_board.dart';
import '../models/ttt.dart';


class TTTApp extends StatelessWidget {
  const TTTApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic-Tac-Toe',
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}


class GameScreen extends StatefulWidget {
  const GameScreen({ super.key });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final TTTModel model = TTTModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                model.reset();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: TTTBoard(
        model: model,
        onTap: _processTap
      ),
    );
  }

  void _processTap(int row, int col) {
    if (model.isGameDone) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Game is over. Please reset to play again.'),
        ),
      );
      return;
    }

    if (!model.playable(row, col)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cell is not playable.'),
        ),
      );
      return;
    }

    setState(() => model.playAt(row, col),);

    if (model.isGameDone) {
      var winner = switch (model.winner()) {
        Player.X => 'X',
        Player.O => 'O',
        _ => null,
      };

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(winner == null ? 'Tie' : 'Winner: $winner'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    model.reset();
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
