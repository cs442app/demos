import 'package:flutter/material.dart';
import '../models/ttt.dart';


class TTTBoard extends StatelessWidget {
  final TTTModel model;
  final Function(int,int)? onTap;

  const TTTBoard({ required this.model, this.onTap, super.key });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final aspectRatio = constraints.maxWidth / constraints.maxHeight;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: aspectRatio
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            int row = index ~/ 3;
            int col = index % 3;
            return InkWell(
              key: ValueKey('cell-$row-$col'),
              onTap: () => onTap?.call(row, col),
              splashColor: Colors.blue,
              hoverColor: Colors.green.withAlpha(100),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Center(
                  child: Icon(
                    switch (model[(row, col)]) {
                      Player.X => Icons.close,
                      Player.O => Icons.circle,
                      _ => null,
                    },
                  ),
                ),
              ),
            );
          },
        );
      }
    );  }
}
