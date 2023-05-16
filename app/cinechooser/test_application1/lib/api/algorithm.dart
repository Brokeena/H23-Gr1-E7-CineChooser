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
int _almostFinish = 1;

// Ce qu'il se passe lorsqu'on doit charger des films quand l'app s'ouvre
Future<void> openApp() async {
  if (firstTime) {
    displayedMovies = await getTopRatedMoviesByGenres(listGenre, 3);
  } else {
    displayedMovies = await getMoviesWithId(displayedMoviesId);
  }
}

//Attendre que les films affichés soit loaded
Future<bool> loadingDisplayedMovie() async {
  if (displayedMovies.isEmpty) {
    return false;
  } else {
    return true;
  }
}

/// Qu'est ce qu'il se passe après avoir swipe un film
Future<void> afterSwipeMovie(int id, bool liked, int index) async {
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


  if((displayedMovies.length-index) <= 10){
    getTopRatedMovies(_almostFinish);
    _almostFinish++;
  }

  addFriendsMovies();
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

//Raccourcir la liste des films affichés quand on change de page
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

// Update les infos Firebase
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

addFriendsMovies() async {
  if (friendList.isNotEmpty) {
    var listId = [];
    for (var friendCode in friendList) {
      var data = await db.doc(friendCode.toString()).get();
      var friendListAmi = data['likedMovies'];
      for (var friendID in friendListAmi) {
        bool alReadyHere = false;
        for(var movie in displayedMovies){
          if(movie.id == friendID){
            alReadyHere = true;
          }
        }
        if (!alReadyHere &&!(displayedMoviesId.contains(friendID)) &&
            !(likedMoviesId.contains(friendID)) &&
            !(dislikedMoviesId.contains(friendID))) {
          listId.add(friendID);
        }
      }
    }

    for(int i = 0; i < listId.length; i++){
      displayedMoviesId.add(listId.elementAt(i));
      displayedMovies.add(await Movie.create(listId.elementAt(i)));
    }
  }
}

Future<List<Movie>> getSimilarLike(String fDocId) async {
  List<Movie> commonMovies = [];
  var data = await db.doc(fDocId).get();
  var friendLikes = data['likedMovies'];
  for(int liked in friendLikes){
    if(likedMoviesId.contains(liked)){
      for(var movie in likedMovies){
        if(movie.id == liked){
          commonMovies.add(movie);
        }
      }
    }
  }
  return commonMovies;
}
