import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinechooser/widget/button_carre.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/pages/choix.dart';
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
          child: Stack(children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover),
                    border: Border.all(
                        color: Colors.transparent,
                        width: 1.5)),
              ),
            ),
            Positioned(
              bottom: 0,
              //top: width/6,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(7),
                child: AutoSizeText(
                  nom,
                  //maxLines: 1,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]),
        ),
        /*
        Center(
          child: AutoSizeText(nom, style: TextStyle(
            color: Styles.white1
          )),
        ),

         */
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
