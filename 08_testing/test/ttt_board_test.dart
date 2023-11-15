import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/models/ttt.dart';
import 'package:testing_demo/views/ttt_board.dart';


Widget createBoard({
  TTTModel? model,
  void Function(int,int)? callback
}) {
  return MaterialApp(
    home: Scaffold(
      body: TTTBoard(
        model: model ?? TTTModel(),
        onTap: callback,
      ),
    ),
  );
}


void main() {
  group('Testing empty board', () {
    testWidgets('Testing if GridView shows up', (tester) async {
      await tester.pumpWidget(createBoard());
      expect(find.byType(GridView), findsOneWidget);
    });   

    testWidgets('Testing if there are nine tap targets', (tester) async {
      await tester.pumpWidget(createBoard());
      expect(find.byType(InkWell), findsNWidgets(9));
    });

    testWidgets('Testing callbacks', (tester) async {
      var (row, col) = (-1, -1);
      void onTap(int r, int c) {
        row = r;
        col = c;
      };

      await tester.pumpWidget(createBoard(callback: onTap));

      for (var r=0; r<3; r++) {
        for (var c=0; c<3; c++) {
          await tester.tap(find.byKey(Key('cell-$r-$c')));
          expect(row, r);
          expect(col, c);
        }
      }
    });
  });

  group('Testing board with moves', () {
    testWidgets('Check first play', (tester) async {
      for (var r=0; r<3; r++) {
        for (var c=0; c<3; c++) {
          var model = TTTModel();
          model.playAt(r, c);
          await tester.pumpWidget(createBoard(model: model));
          expect(find.byIcon(Icons.close), findsOneWidget);
        }
      }
    });   

    testWidgets('Check second play', (tester) async {
      for (var r=0; r<3; r++) {
        for (var c=0; c<3; c++) {
          if (r == 0 && c == 0) {
            continue;
          }
          var model = TTTModel();
          model.playAt(0, 0);
          model.playAt(r, c);
          await tester.pumpWidget(createBoard(model: model));
          expect(find.byIcon(Icons.close), findsOneWidget);
          expect(find.byIcon(Icons.circle), findsOneWidget);
        }
      }
    });   
  });
}
