import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../api/movie.dart';

class MovieSwipe extends StatelessWidget {
   MovieSwipe({
    required this.id,
    super.key,
  });

  var poster = '';
  var name = '';

  Future showMovies(var moviesId) async{
    Movie movie = await Movie.create(moviesId);
    poster = movie.poster;
    name = movie.nom;
  }

  final int id;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    showMovies(id);
    print(poster);
    return ClipRRect(
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
          ),
        ],
      ),
    );
  }
}
