import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:cinechooser/pages/login_page.dart';

class DislikedMovies extends StatefulWidget {
  const DislikedMovies({Key? key}) : super(key: key);

  @override
  State<DislikedMovies> createState() => _DislikedMoviesState();
}

class _DislikedMoviesState extends State<DislikedMovies> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: SingleChildScrollView(
          child: Center(
            child: Wrap(
              spacing: width / 9,
              runSpacing: width / 9,
              direction: Axis.horizontal,
              children: dislikedMovies.reversed.map((movie) {
                return Container(
                  width: width / 3,
                  height: width / 2,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(movie.poster, maxWidth: (width/3).toInt(), maxHeight: (width/2).toInt()),
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
