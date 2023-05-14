import 'package:flutter/material.dart';

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
              )))
        ],
      ),
    );
  }
}
