import 'package:flutter/material.dart';

class DividerHandle extends StatelessWidget {
  const DividerHandle({
    super.key,
    required this.axis,
    required this.color,
    this.showGuide = false,
  });

  final Axis axis;
  final Color color;
  final bool showGuide;

  @override
  Widget build(BuildContext context) {
    final horizontal = axis == Axis.horizontal;

    return IgnorePointer(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: showGuide ? _DashedDividerPainter(axis: axis) : null,
          child: Center(
            child: Container(
              width: horizontal ? 34 : 7,
              height: horizontal ? 7 : 34,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).colorScheme.surface,
                  width: 1.5,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedDividerPainter extends CustomPainter {
  const _DashedDividerPainter({required this.axis});

  final Axis axis;

  @override
  void paint(Canvas canvas, Size size) {
    const dashLength = 8.0;
    const gapLength = 3.0;
    final horizontal = axis == Axis.horizontal;
    final length = horizontal ? size.width : size.height;
    final crossPosition = horizontal ? size.height / 2 : size.width / 2;
    final outlinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95)
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round;
    final linePaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.95)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    for (
      double position = 0;
      position < length;
      position += dashLength + gapLength
    ) {
      final end = (position + dashLength).clamp(0.0, length);
      final startOffset = horizontal
          ? Offset(position, crossPosition)
          : Offset(crossPosition, position);
      final endOffset = horizontal
          ? Offset(end, crossPosition)
          : Offset(crossPosition, end);
      canvas.drawLine(startOffset, endOffset, outlinePaint);
      canvas.drawLine(startOffset, endOffset, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DashedDividerPainter oldDelegate) =>
      oldDelegate.axis != axis;
}
