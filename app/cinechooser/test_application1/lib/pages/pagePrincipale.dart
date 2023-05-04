import 'package:cinechooser/utils/top_buttons_row.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:flutter/foundation.dart';
import 'package:cinechooser/utils/movie_carte.dart';
import 'package:cinechooser/utils/bottom_buttons_row.dart';
import '../utils/app_styles.dart';
import '../utils/carte_overlay.dart';
import 'package:cinechooser/api/movie.dart';
import 'package:cinechooser/api/api.dart';
import 'package:cinechooser/main.dart';

class PagePrincipale extends StatefulWidget {
  const PagePrincipale({Key? key}) : super(key: key);


  @override
  State<PagePrincipale> createState() => _PagePrincipaleState();
}

class _PagePrincipaleState extends State<PagePrincipale> {

  final user = FirebaseAuth.instance.currentUser!;

  final controller = SwipableStackController();

  List<int> likedMovies = [];

  late final SwipableStackController _controller;

  void _listenController() => setState(() {});

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  _addRecommendedMovies(int id, int numberOfRecommendation) async {
    var similarMovies = await getRecommendedMovies(id);
    int r = similarMovies.length;
    if(numberOfRecommendation <= r){
      r = numberOfRecommendation;
    }

    for(int x = 0; x < r; x++){
      bool alreadyHere = false;
      for(int d = 0; d < displayedMovies.length; d++){
        if(displayedMovies.elementAt(d).id == similarMovies.elementAt(x).id){
          alreadyHere = true;
        }
      }

      if(!alreadyHere){
        displayedMovies.add(similarMovies.elementAt(x));
      } else  {
        if(r+1 <= similarMovies.length){
          r+=1;
        }
      }
    }
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
              onSwipeCompleted: (index, direction) {
                if(direction == SwipeDirection.right){
                  likedMovies.add(displayedMovies.elementAt(index).id);
                  _addRecommendedMovies(displayedMovies.elementAt(index).id, 2);
                }
                print(likedMovies);
                if (kDebugMode) {
                  print('$index, $direction'); //debug
                }
              },
              builder: (context, properties) {
                final indexMovie = properties.index % (displayedMovies.length);
                List<String> genreNames = [];
                for(int i = 0; i < displayedMovies.elementAt(indexMovie).genres.length; i++){
                  genreNames.add(displayedMovies.elementAt(indexMovie).genres.elementAt(i).name);
                }
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Center(
                        child: SizedBox(
                          height: heigth * 0.65,
                          width: width * 0.9,
                          child: Cartes(
                            name: displayedMovies.elementAt(indexMovie).nom,
                            genres: genreNames.join(", "),
                            poster:
                                displayedMovies.elementAt(indexMovie).poster,
                          ),
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
              onRewindTap: _controller.rewind,
              canRewind: _controller.canRewind,
            ),
          ],
        ),
      ),
    );
  }
}
