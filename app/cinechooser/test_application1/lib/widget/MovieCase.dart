import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

bool pressed = false;
Color color = Colors.transparent;
//double border = 6;

class MovieCase extends StatelessWidget {
  MovieCase({
    super.key,
    // required this.genreId,
    required this.nom,
    required this.image,
    required this.color,
    // required this.selectionne,
  });

  //final int genreId;
  final String nom;
  final String image;
  final Color color;

  // bool selectionne;

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
                        image: AssetImage(image), fit: BoxFit.cover),
                    border: Border.all(color: color, width: 2)
                ),
                child: Container(
                  height: width / 4,
                  width: width / 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87]),
                      border: Border.all(color: color, width: 2),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              //top: width/6,
              left: 0,
              right: 0,
              child: Container(
                /*
                height: width / 8,
                width: width / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.red])),

                 */
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: AutoSizeText(
                    nom,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
        /*Button(
            onPressed: () {
              if (selectionne) {
                listGenre.add(genreId);
                border = 15;
                selectionne = false;
              } else {
                listGenre.remove(genreId);
                border = 0;
                selectionne = true;
              }
            },
            icone: const Icon(
              Icons.arrow_drop_down,
              color: Colors.transparent,
            ),
            color: Colors.transparent,
            taille: width / 4,
            borderRadius: 20) */
      ]),
    );
  }
}
