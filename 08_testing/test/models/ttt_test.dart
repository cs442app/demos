import 'package:testing_demo/models/ttt.dart';
import 'package:test/test.dart';

void main() {
  group('TicTacToe model gameplay tests', () {
    test('Initial board state', () {
      var ttt = TTTModel();
      expect(ttt.currentPlayer, Player.X);
      for (var row = 0; row < 3; row++) {
        for (var col = 0; col < 3; col++) {
          expect(ttt.playable(row, col), true);
        }
      }
    });

    test('Test gameplay API', () {
      var ttt = TTTModel();
      ttt.playAt(0, 0);
      expect(ttt[(0, 0)], Player.X);
      expect(ttt.currentPlayer, Player.O);

      ttt.playAt(2, 2);
      expect(ttt[(2, 2)], Player.O);
      expect(ttt.currentPlayer, Player.X);

      for (var r=0; r<3; r++) {
        for (var c=0; c<3; c++) {
          if (r == 0 && c == 0 || r == 2 && c == 2) {
            continue;
          }
          expect(ttt.playable(r, c), true);
          expect(ttt[(r, c)], null);
        }
      }

      ttt.reset();
      expect(ttt.currentPlayer, Player.X);
      for (var r=0; r<3; r++) {
        for (var c=0; c<3; c++) {
          expect(ttt.playable(r, c), true);
          expect(ttt[(r, c)], null);
        }
      }
    });
  });


  group('TicTacToe game over / winner tests', () {
    test('Test if game is not done', () {
      var ttt = TTTModel();
      expect(ttt.isGameDone, false);
    });

    test('Test win by X', () {
      var ttt = TTTModel();
      ttt.playAt(0, 0);
      ttt.playAt(1, 0);
      ttt.playAt(0, 1);
      ttt.playAt(1, 1);
      ttt.playAt(0, 2);
      expect(ttt.isGameDone, true);
      expect(ttt.winner(), Player.X);
    });

    test('Test win by O', () {
      var ttt = TTTModel();
      ttt.playAt(0, 0);
      ttt.playAt(1, 0);
      ttt.playAt(0, 1);
      ttt.playAt(1, 1);
      ttt.playAt(2, 0);
      ttt.playAt(1, 2);
      expect(ttt.isGameDone, true);
      expect(ttt.winner(), Player.O);
    });

    test('Test draw', () {
      var ttt = TTTModel();
      ttt.playAt(0, 0);
      ttt.playAt(0, 1);
      ttt.playAt(0, 2);
      ttt.playAt(1, 0);
      ttt.playAt(1, 2);
      ttt.playAt(1, 1);
      ttt.playAt(2, 0);
      ttt.playAt(2, 2);
      ttt.playAt(2, 1);
      expect(ttt.isGameDone, true);
      expect(ttt.winner(), null);
    });
  });



}
