import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GNav(
        gap: 8,
        color: Styles.grey1,
        activeColor: Styles.white1,
        tabActiveBorder: Border.all(color: Colors.grey.shade700),
        tabBackgroundColor: Colors.grey.shade800,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 24,
        tabs: [
          GButton(
            icon: Icons.favorite,
            text: 'Like',
          ),
          GButton(
            icon: Icons.heart_broken,
            text: 'Dislike',
          )
        ],
      ),
    );
  }
}
