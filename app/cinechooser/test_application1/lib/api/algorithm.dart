import 'package:cinechooser/api/movie.dart';
import 'package:cinechooser/pages/choix.dart';
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
bool _justSwiped = false;

/// What happen when you open the app
Future<void> openApp() async {
  if (firstTime) {
    displayedMovies = await getTopRatedMoviesByGenres(listGenre, 3);
  } else {
    displayedMovies = await getMoviesWithId(displayedMoviesId);
  }
}

Future<bool> loadingDisplayedMovie() async {
  if (displayedMovies.isEmpty) {
    return false;
  } else {
    return true;
  }
}

/// Modification de page principale
Future<void> swipeMovie(int id, bool liked, int index) async {
  _justSwiped = true;
  if (firstTime) {
    firstTime = false;
    db.doc(docID).update({'firstTime': firstTime});
  }

  if (liked) {
    likedMoviesId.add(id);
    db.doc(docID).update({'likedMovies': likedMoviesId});
    likedMovies.add(await Movie.create(id));
    var list = [];
    for(var movie in likedMovies){
      list.add(movie.id);
    }
    print(list);
    addRecommendedMovies(id, 3);
  } else if (!liked) {
    dislikedMoviesId.add(id);
    db.doc(docID).update({'dislikedMovies': dislikedMoviesId});
    dislikedMovies.add(await Movie.create(id));
  }

  lastSwipe = id;
  if (lastSwipe != 0) {
    displayedMoviesId.remove(lastSwipe);
  }


  friendsMovies();
  updateDisplayedMoviesId();
}

Future<void> onRewind() async {
  if(likedMoviesId.contains(lastSwipe)){
    likedMovies.removeAt(likedMoviesId.indexOf(lastSwipe));
    likedMoviesId.remove(lastSwipe);

  } else if(dislikedMoviesId.contains(lastSwipe)){
    dislikedMovies.removeAt(dislikedMoviesId.indexOf(lastSwipe));
    dislikedMoviesId.remove(lastSwipe);
  }
  lastSwipe = 0;
}

/// Modifier la liste
addRecommendedMovies(int id, int numberOfRecommendation) async {
  var similarMovies = await getRecommendedMovies(id);
  int r = similarMovies.length;
  if (numberOfRecommendation <= r) {
    r = numberOfRecommendation;
  }

  for (int x = 0; x < r; x++) {
    bool alreadyHere = false;
    for (int d = 0; d < displayedMovies.length; d++) {
      if (displayedMovies.elementAt(d).id == similarMovies.elementAt(x).id ||
          likedMoviesId.contains(similarMovies.elementAt(x).id) ||
          dislikedMoviesId.contains(similarMovies.elementAt(x).id)) {
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


void trimDisplayedMovie() {
  List<Movie> newMovieList = [];

  var lastLikedMovieId = 0;
  if (likedMoviesId.isNotEmpty) {
    lastLikedMovieId = likedMoviesId.elementAt(likedMoviesId.length - 1);
  }
  var lastDislikedMovieId = 0;
  if (dislikedMoviesId.isNotEmpty) {
    lastDislikedMovieId =
        dislikedMoviesId.elementAt(dislikedMoviesId.length - 1);
  }

  int lastLikedMovieIndex = 0;
  int lastDislikedMovieIndex = 0;

  for (int x = 0; x < displayedMovies.length; x++) {
    if (lastLikedMovieId == displayedMovies.elementAt(x).id) {
      lastLikedMovieIndex = x;
    }
  }
  for (int y = 0; y < displayedMovies.length; y++) {
    if (lastDislikedMovieId == displayedMovies.elementAt(y).id) {
      lastDislikedMovieIndex = y;
    }
  }

  int lastIndex = lastDislikedMovieIndex;
  if (lastLikedMovieIndex > lastDislikedMovieIndex) {
    lastIndex = lastLikedMovieIndex;
  }
  if (_justSwiped) {
    lastIndex += 1;
  }

  for (int i = lastIndex; i < displayedMovies.length; i++) {
    newMovieList.add(displayedMovies.elementAt(i));
  }
  _justSwiped = false;

  displayedMovies = newMovieList;
}

/// Update Firebase
updateDisplayedMoviesId() async {
  displayedMoviesId = [];
  for (var movie in displayedMovies) {
    if (!(dislikedMoviesId.contains(movie.id)) &&
        !(likedMoviesId.contains(movie.id))) {
      displayedMoviesId.add(movie.id);
    }
  }
  db.doc(docID).update({'displayedMoviesId': displayedMoviesId});
}

friendsMovies() async {
  if (friendList.isNotEmpty) {
    for (var friendCode in friendList) {
      var data = await db.doc(friendCode.toString()).get();
      var friendListAmi = data['likedMovies'];
      for (var friendID in friendListAmi) {
        bool alreadyHere = false;
        if (!(displayedMoviesId.contains(friendID)) ||
            !(likedMoviesId.contains(friendID)) ||
            !(dislikedMoviesId.contains(friendID))) {
          displayedMoviesId.add(friendID);
        }
      }
    }
  }
}
