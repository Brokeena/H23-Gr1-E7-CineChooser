import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:cinechooser/widget/button.dart';

class BottomButtonsRow extends StatelessWidget {
  const BottomButtonsRow({
    required this.onRewindTap,
    required this.onSwipe,
    required this.canRewind,
    super.key,
  });

  final bool canRewind;
  final VoidCallback onRewindTap;
  final ValueChanged<SwipeDirection> onSwipe;

  static const double height = 100;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                color: canRewind ? Colors.white : Colors.grey,
                onPressed: canRewind ? onRewindTap : null,
                icone: const Icon(Icons.refresh, color: Styles.red1),
                taille: 64,
                borderRadius: 100,
              ),

              Button(
                color: Styles.red1,
                onPressed: () {
                  onSwipe(SwipeDirection.right);
                },
                icone: const Icon(
                  Icons.favorite,
                  color: Styles.white1,
                  size: 45,
                  shadows: [
                    BoxShadow(
                    color: Styles.grey1,
                    blurRadius: 15,
                    spreadRadius: 10,
                  )
                ],
                ),
                taille: 96,
                borderRadius: 100,
              ),
              //awvawfvawfvawf
              Button(
                color: Colors.white,
                icone: const Icon(Icons.clear, color: Styles.red1),
                onPressed: () {
                  onSwipe(SwipeDirection.left);
                },
                taille: 96,
                borderRadius: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
