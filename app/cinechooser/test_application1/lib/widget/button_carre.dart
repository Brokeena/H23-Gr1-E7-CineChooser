import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';

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
          overlayColor: MaterialStateProperty.resolveWith(
                (states) => Colors.red,
          ),
          elevation: MaterialStateProperty.resolveWith(
                (states) => 0.0,
          ),

        ),
        onPressed: onPressed,
        child: icone,
      ),
    );
  }
}




