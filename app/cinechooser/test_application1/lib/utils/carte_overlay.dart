import 'dart:math' as math;
import 'package:cinechooser/utils/type_carte.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

class OverlayCarte extends StatelessWidget {
  const OverlayCarte({
    required this.direction,
    required this.swipeProgress,
    super.key,
  });

  final SwipeDirection direction;
  final double swipeProgress;

  @override
  Widget build(BuildContext context) {
    final opacity = math.min<double>(swipeProgress, 1);
    final isRight = direction == SwipeDirection.right;
    final isLeft = direction == SwipeDirection.left;

    return Stack(
      children: [
        Opacity(
          opacity: isRight ? opacity : 0,
          child: CardLabel.right(),
        ),
        Opacity(
          opacity: isLeft ? opacity : 0,
          child: CardLabel.left(),
        ),
      ],
    );
  }
}
