import 'package:cinechooser/pages/main_page.dart';
import 'package:cinechooser/pages/reglages.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/widget/button_carre.dart';

import '../pages/profile.dart';

class TopButtonsRow extends StatelessWidget {
  const TopButtonsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Button(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              },
              icone: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: Styles.red1),
              color: Colors.white,
              taille: 64,
              borderRadius: 15),
          Button(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
              icone: const Icon(Icons.person, color: Styles.red1),
              color: Colors.white,
              taille: 64,
              borderRadius: 100),
          Button(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Reglages()),
                );
              },
              icone: const Icon(Icons.menu, color: Styles.red1),
              color: Colors.white,
              taille: 64,
              borderRadius: 15),
        ],
      ),
    );
  }
}
