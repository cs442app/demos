import 'package:flutter/material.dart';

enum Player { X, O }

class TTTModel extends ChangeNotifier {
  List<List<Player?>> _board = List.generate(3, (_) => List.filled(3, null));
  
  Player _currentPlayer = Player.X;

  Player get currentPlayer => _currentPlayer;

  Player? operator []((int,int) position) {
    var (row, col) = position;
    return _board[row][col];
  }

  bool get isGameDone => winner() != null 
    || _board.every((row) => row.every((cell) => cell != null));

  void reset() {
    _board = List.generate(3, (_) => List.filled(3, null));
    _currentPlayer = Player.X;
    notifyListeners();
  }

  bool playable(int row, int col) {
    return _board[row][col] == null;
  }

  void playAt(int row, int col) {
    if (!isGameDone && _board[row][col] == null) {
      _board[row][col] = _currentPlayer;
      _currentPlayer = _currentPlayer == Player.X ? Player.O : Player.X;
      notifyListeners();
    }
  }

  Player? winner() {
    // Check rows
    for (int row = 0; row < 3; row++) {
      if (_board[row][0] != null &&
          _board[row][0] == _board[row][1] &&
          _board[row][0] == _board[row][2]) {
        return _board[row][0];
      }
    }

    // Check columns
    for (int col = 0; col < 3; col++) {
      if (_board[0][col] != null &&
          _board[0][col] == _board[1][col] &&
          _board[0][col] == _board[2][col]) {
        return _board[0][col];
      }
    }

    // Check diagonals
    if (_board[0][0] != null &&
        _board[0][0] == _board[1][1] &&
        _board[0][0] == _board[2][2]) {
      return _board[0][0];
    }
    if (_board[0][2] != null &&
        _board[0][2] == _board[1][1] &&
        _board[0][2] == _board[2][0]) {
      return _board[0][2];
    }

    // No winner
    return null;
  }
}
