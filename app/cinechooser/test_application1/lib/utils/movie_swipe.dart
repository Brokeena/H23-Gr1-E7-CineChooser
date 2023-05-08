import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../api/movie.dart';

class MovieSwipe extends StatelessWidget {
  MovieSwipe({
    required this.id,
    required this.name,
    required this.poster,
    super.key,
  });


  final int id;
  final String name;
  final String poster;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(poster);
    return ClipRRect(
      child: Stack(
        children: [
          SizedBox(
              width: width / 3,
              height: height / 3.5,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(poster), fit: BoxFit.cover),
              )

                  /*
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.cyan,
                image: DecorationImage(
                    image: NetworkImage(poster), fit: BoxFit.cover),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height/5,
              width: width/3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Styles.nom),
              ],
            ),
          ),*/
                  ))
        ],
      ),
    );
  }
}
