import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/pages/login_page.dart';

class LikedMovies extends StatefulWidget {
  const LikedMovies({Key? key}) : super(key: key);

  @override
  State<LikedMovies> createState() => _LikedMoviesState();
}

class _LikedMoviesState extends State<LikedMovies> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(likedMovies.length);

    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: SingleChildScrollView(
          child: Center(
            child: Wrap(
              spacing: width / 9,
              runSpacing: width / 9,
              direction: Axis.horizontal,
              children: likedMovies.reversed.map((movie) {
                return Container(
                  width: width / 3,
                  height: width / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(movie.poster),
                      fit: BoxFit.cover,
                    )
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }
}
