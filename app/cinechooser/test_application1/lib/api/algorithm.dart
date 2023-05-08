import 'package:cinechooser/pages/login_page.dart';
import 'package:cinechooser/utils/top_buttons_row.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:flutter/foundation.dart';
import 'package:cinechooser/utils/movie_carte.dart';
import 'package:cinechooser/utils/bottom_buttons_row.dart';
import '../utils/app_styles.dart';
import 'package:cinechooser/api/api.dart';
import 'package:cinechooser/main.dart';

int lastSwipe = 0;


/// What happen when you open the app
void openApp() async{
  if(firstTime){
    displayedMovies = await getTopRatedMoviesByGenres(genres, 2);
    firstTime = false;
  } else {
    displayedMovies = await getMoviesWithId(displayedMoviesId);

  }
}

void afterALike(){

}


addRecommendedMovies(int id, int numberOfRecommendation) async {
  var similarMovies = await getRecommendedMovies(id);
  int r = similarMovies.length;
  if (numberOfRecommendation <= r) {
    r = numberOfRecommendation;
  }

  for (int x = 0; x < r; x++) {
    bool alreadyHere = false;
    for (int d = 0; d < displayedMovies.length; d++) {
      if (displayedMovies.elementAt(d).id == similarMovies.elementAt(x).id) {
        alreadyHere = true;
      }
    }

    if (!alreadyHere) {
      displayedMovies.add(similarMovies.elementAt(x));
    } else {
      if (r + 1 <= similarMovies.length) {
        r += 1;
      }
    }
  }
}

Future<void> swipeMovie(int id, bool liked) async {
  if(liked){
    likedMovies.add(id);
    db.doc(goodID).update({'likedMovies': likedMovies});
  } else if(!liked){
    dislikedMovies.add(id);
    db.doc(goodID).update({'dislikedMovies': dislikedMovies});
  }

  if(lastSwipe != 0){
    displayedMoviesId.remove(lastSwipe);
  }
  lastSwipe = id;

  db.doc(goodID).update({'dislikedMovies': dislikedMovies});
}

void onRewind(){
  dislikedMovies.remove(lastSwipe);
  likedMovies.remove(lastSwipe);
  lastSwipe = 0;
}