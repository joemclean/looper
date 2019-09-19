import 'dart:math' as Math;
import 'package:beatmaker/theme/splice/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleProgressIndicator extends StatelessWidget {
  final double percentage;
  final bool inverse;
  CircleProgressIndicator({
    @required this.percentage,
    this.inverse = false,
  });
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(width: 100, height: 100),
      painter: CircleProgressPainter(
        percentage: percentage,
        inverse: inverse,
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  double percentage;
  bool inverse = false;
  CircleProgressPainter({@required this.percentage, this.inverse});
  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 5.0;
    final Offset center = size.center(Offset.zero);
    final Size constrainedSize = size - Offset(strokeWidth, strokeWidth);
    final double shortestSide =
        Math.min(constrainedSize.width, constrainedSize.height);
    final double radius = shortestSide / 2;

    final double startAngle = -(2 * Math.pi * 0.25);
    final double endAngle = 2 * Math.pi * (this.percentage ?? 0);

    final foregroundPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final inversePaint = Paint()
      ..color = SDSColors.gray30
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (inverse == false) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle,
        false,
        foregroundPaint,
      );
    } else {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        endAngle + startAngle,
        (2 * Math.pi) - endAngle,
        false,
        inversePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CircleProgressPainter oldDelegate) {
    return (oldDelegate.percentage != this.percentage);
  }
}
