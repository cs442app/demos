import 'dart:ui';
import 'package:flutter/material.dart';

class DrawingWidget extends StatefulWidget {
  const DrawingWidget({super.key});

  @override
  State<DrawingWidget> createState() => _DrawingWidgetState();
}

class _DrawingWidgetState extends State<DrawingWidget> {
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          // convert the touch point from global to local coordinates
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          points.add(renderBox.globalToLocal(details.globalPosition));
        });
      },
      onPanEnd: (details) {
        points.add(null); // to lift the pen up
      },
      child: CustomPaint(
        size: Size.infinite,
        painter: Painter(points),
      ),
    );
  }
}

class Painter extends CustomPainter {
  final List<Offset?> points;

  Painter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    // draw a red line
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    // draw the line segments
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        // Draw dots when a touch point is lifted
        canvas.drawPoints(PointMode.points, [points[i]!], paint);
      }
    }
  }

  @override
  // this is called when the CustomPainter is rebuilt
  bool shouldRepaint(Painter oldDelegate) => true;
}
