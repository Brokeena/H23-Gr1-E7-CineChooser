import 'package:cinechooser/pages/login_page.dart';
import 'package:cinechooser/pages/reglages.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:cinechooser/pages/pagePrincipale.dart';

class TopButtonsRow extends StatelessWidget {
  const TopButtonsRow({
    super.key,
  });

  static const double height = 100;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 64,
            width: 64,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.resolveWith(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: Styles.red1),
            ),
          ),
          SizedBox(
            height: 64,
            width: 64,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.resolveWith(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Reglages()),
                );
              },
              child: const Icon(Icons.menu, color: Styles.red1),
            ),
          )
        ],
      ),
    );
  }
}
