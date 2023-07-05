import 'package:flutter/material.dart';

import '../../models/project.dart';

class TitleCard extends StatelessWidget {
  const TitleCard(
    this.project, {
    super.key,
  });
  final Project project;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomPaint(
            painter: _ColoredTextPainter(
                text: project.title, color: Colors.black54, clipWidth: 0)),
        CustomPaint(
            painter: _ColoredTextPainter(
                text: project.title,
                color: Theme.of(context).colorScheme.background,
                clipWidth: 180)),
      ],
    );
  }
}

class _ColoredTextPainter extends CustomPainter {
  final String text;
  final Color color;
  final double clipWidth;

  _ColoredTextPainter({
    required this.text,
    required this.color,
    required this.clipWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 70,
          fontFamily: 'MartianMono',
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(2, 1),
              blurRadius: 1,
            )
          ],
        ),
      ),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    canvas.clipPath(Path()
      ..moveTo(clipWidth, 0)
      ..lineTo(clipWidth + 200, 0)
      ..lineTo(clipWidth + 192, textPainter.height)
      ..lineTo(clipWidth - 8, textPainter.height)
      ..close());

    textPainter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(_ColoredTextPainter oldDelegate) {
    return text != oldDelegate.text ||
        color != oldDelegate.color ||
        clipWidth != oldDelegate.clipWidth;
  }
}
