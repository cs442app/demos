import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/models/ttt.dart';
import 'package:testing_demo/views/ttt_board.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


// generate a mock class for TTTModel
@GenerateMocks([TTTModel])
import 'ttt_board_test.mocks.dart';


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


  group('Testing board with real model object', () {
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
          expect(find.byIcon(Icons.circle_outlined), findsOneWidget);
        }
      }
    });   
  });



  group('Testing board with mock model object', () {
    testWidgets('All Xs', (tester) async {
      var model = MockTTTModel();
      
      when(model[any]).thenReturn(Player.X);
      when(model.playable(any, any)).thenReturn(false);

      await tester.pumpWidget(createBoard(model: model));
      expect(find.byIcon(Icons.close), findsNWidgets(9));
    });

    testWidgets('All Os', (tester) async {
      var model = MockTTTModel();

      when(model[any]).thenReturn(Player.O);
      when(model.playable(any, any)).thenReturn(false);

      await tester.pumpWidget(createBoard(model: model));
      expect(find.byIcon(Icons.circle_outlined), findsNWidgets(9));
    });

    testWidgets('Xs and Os', (tester) async {
      var model = MockTTTModel();

      for (var r=0; r<3; r++) {
        for (var c=0; c<3; c++) {
          if ((r*3+c) % 2 == 0) {
            when(model[(r, c)]).thenReturn(Player.X);
          } else {
            when(model[(r, c)]).thenReturn(Player.O);
          }
        }
      }

      await tester.pumpWidget(createBoard(model: model));
      expect(find.byIcon(Icons.close), findsNWidgets(5));
      expect(find.byIcon(Icons.circle_outlined), findsNWidgets(4));
    });
  });
}
