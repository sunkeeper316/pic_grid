import 'package:flutter/material.dart';

class DividerHandle extends StatelessWidget {
  const DividerHandle({super.key, required this.axis, required this.color});

  final Axis axis;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final horizontal = axis == Axis.horizontal;

    return IgnorePointer(
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
    );
  }
}
