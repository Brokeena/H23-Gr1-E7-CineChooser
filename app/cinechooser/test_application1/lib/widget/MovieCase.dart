import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinechooser/widget/button_carre.dart';
import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class MovieCase extends StatelessWidget {
  const MovieCase({
    super.key,
    required this.onPressed,
    required this.nom,
    required this.image,
  });

  final VoidCallback? onPressed;
  final String nom;
  final String image;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ClipRRect(
      child: Stack(children: [
        SizedBox(
          height: width / 4,
          width: width / 4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
            ),
          ),
        ),
        Center(
            child: Padding(
              padding: EdgeInsets.only(top: width / 5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: AutoSizeText(nom, style: Styles.informations),
          ),
        )),
        Button(
            onPressed: onPressed,
            icone: const Icon(
              Icons.arrow_drop_down,
              color: Colors.transparent,
            ),
            color: Colors.transparent,
            taille: width / 4,
            borderRadius: 20)
      ]),
    );
  }
}
