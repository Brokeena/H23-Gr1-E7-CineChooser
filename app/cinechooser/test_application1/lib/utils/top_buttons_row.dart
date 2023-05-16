import 'package:cinechooser/pages/login_page.dart';
import 'package:cinechooser/pages/main_page.dart';
import 'package:cinechooser/pages/reglages.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/widget/button_carre.dart';
import '../pages/catalogue.dart';

class TopButtonsRow extends StatelessWidget {
  const TopButtonsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width/20, vertical: width/20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Button(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Catalogue()),
                );
              },
              icone: const Icon(Icons.thumbs_up_down, color: Styles.red1,size: 40),
              color: Colors.white,
              taille: 70,
              borderRadius: 20),
          Button(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Reglages()),
                );
              },
              icone: const Icon(Icons.person, color: Styles.red1, size: 40),
              color: Colors.white,
              taille: 70,
              borderRadius: 20),
        ],
      ),
    );
  }
}
