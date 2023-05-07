import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';

class MovieSwipe extends StatelessWidget {
  const MovieSwipe({
    required this.name,
    required this.poster,
    super.key,
  });


  final String name;
  final String poster;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(14),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black12.withOpacity(0),
                    Colors.black12.withOpacity(.4),
                    Colors.black12.withOpacity(.6),
                    Colors.black12.withOpacity(.82),
                  ],
                ),
              ),
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
