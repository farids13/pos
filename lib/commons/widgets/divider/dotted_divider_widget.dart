import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double spaceLength;

  const DottedDivider({
    super.key,
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.dashLength = 5.0,
    this.spaceLength = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedDividerPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashLength: dashLength,
        spaceLength: spaceLength,
      ),
      size: Size.fromHeight(strokeWidth),
    );
  }
}

class DottedDividerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double spaceLength;

  const DottedDividerPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.spaceLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < size.width / (dashLength + spaceLength); i++) {
      canvas.drawLine(
        Offset(i * (dashLength + spaceLength), 0),
        Offset(i * (dashLength + spaceLength) + dashLength, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
