import 'dart:math' as math;
import 'package:flutter/material.dart';

const _labelAngle = math.pi / 2 * 0.2;

class CardLabel extends StatelessWidget {
  const CardLabel._({
    required this.color,
    required this.label,
    required this.angle,
    required this.alignment,
  });

  factory CardLabel.right() {
    return const CardLabel._(
      color: Color.fromRGBO(70, 195, 120, 1),
      label: 'RIGHT',
      angle: -_labelAngle,
      alignment: Alignment.topLeft,
    );
  }

  factory CardLabel.left() {
    return const CardLabel._(
      color: Color.fromRGBO(220, 90, 108, 1),
      label: 'LEFT',
      angle: _labelAngle,
      alignment: Alignment.topRight,
    );
  }

  factory CardLabel.up() {
    return const CardLabel._(
      color: Color.fromRGBO(83, 170, 232, 1),
      label: 'UP',
      angle: _labelAngle,
      alignment: Alignment(0, 0.5),
    );
  }

  factory CardLabel.down() {
    return const CardLabel._(
      color: Color.fromRGBO(154, 85, 215, 1),
      label: 'DOWN',
      angle: -_labelAngle,
      alignment: Alignment(0, -0.75),
    );
  }

  final Color color;
  final String label;
  final double angle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(
        vertical: 36,
        horizontal: 36,
      ),
      child: Transform.rotate(
        angle: angle,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
              width: 4,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(6),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
              color: color,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
