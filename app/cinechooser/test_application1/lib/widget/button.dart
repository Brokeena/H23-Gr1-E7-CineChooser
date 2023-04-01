import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key,
    required this.onPressed,
    required this.icone,
    required this.color,
    required this.taille,
    required this.borderRadius,
  });

  final VoidCallback? onPressed;
  final Icon icone;
  final Color color;
  final double taille;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: taille,
      width: taille,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
                (states) => color,
          ),
        ),
        onPressed: onPressed,
        child: icone,
      ),
    );
  }
}




