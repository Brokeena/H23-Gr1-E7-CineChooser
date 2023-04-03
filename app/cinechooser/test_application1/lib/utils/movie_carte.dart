import 'package:cinechooser/utils/bottom_buttons_row.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';

class Cartes extends StatelessWidget {
  const Cartes({
    required this.name,
    required this.poster,
    required this.genres,
    super.key,
  });

  final String genres;
  final String name;
  final String poster;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(poster), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Styles.preTitre),
                Text(genres, style: Styles.informations),
                const SizedBox(height: BottomButtonsRow.height)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
