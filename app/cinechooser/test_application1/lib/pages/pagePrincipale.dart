import 'package:cinechooser/widget/Boutons/top_buttons_row.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:flutter/foundation.dart';
import 'package:cinechooser/widget/movie_carte.dart';
import 'package:cinechooser/widget/Boutons/bottom_buttons_row.dart';
import '../api/algorithm.dart';
import '../utils/app_styles.dart';
import 'package:cinechooser/main.dart';

import 'Connexions/login_page.dart';

class PagePrincipale extends StatefulWidget {
  const PagePrincipale({Key? key}) : super(key: key);

  @override
  State<PagePrincipale> createState() => _PagePrincipaleState();
}

class _PagePrincipaleState extends State<PagePrincipale> {
  final user = FirebaseAuth.instance.currentUser!;

  final controller = SwipableStackController();

  late final SwipableStackController _controller;

  void _listenController() => setState(() {});

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            const TopButtonsRow(),
            SwipableStack(
              detectableSwipeDirections: const {
                SwipeDirection.right,
                SwipeDirection.left,
              },
              controller: _controller,
              stackClipBehaviour: Clip.none,
              onSwipeCompleted: (index, direction) async {
                if (direction == SwipeDirection.right) {
                  await afterSwipeMovie(displayedMovies.elementAt(index).id, true, index);
                } else if (direction == SwipeDirection.left) {
                  await afterSwipeMovie(displayedMovies.elementAt(index).id, false, index);
                }
              },
              builder: (context, properties) {
                final indexMovie = properties.index % (displayedMovies.length);
                // Créer un String de genre
                List<String> genreNames = [];
                for (int i = 0;
                    i < displayedMovies.elementAt(indexMovie).genres.length;
                    i++) {
                  genreNames.add(displayedMovies
                      .elementAt(indexMovie)
                      .genres
                      .elementAt(i)
                      .name);
                } //

                for (int i = 0;
                    i < displayedMovies.elementAt(indexMovie).genres.length;
                    i++) {
                  genreNames.add(displayedMovies
                      .elementAt(indexMovie)
                      .genres
                      .elementAt(i)
                      .name);
                }
                return Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        height: heigth * 0.65,
                        width: width * 0.9,
                        child: Cartes(
                          name: displayedMovies.elementAt(indexMovie).nom,
                          infos:
                              "${displayedMovies.elementAt(indexMovie).dateDeSortie} - ${displayedMovies.elementAt(indexMovie).directors.elementAt(0)}" /*genreNames.join(", ")*/,
                          poster:
                              displayedMovies.elementAt(indexMovie).poster,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            BottomButtonsRow(
              onSwipe: (direction) {
                _controller.next(swipeDirection: direction);
              },
              onRewindTap:_controller.rewind,
              canRewind: _controller.canRewind,
            ),
          ],
        ),
      ),
    );
  }
}
