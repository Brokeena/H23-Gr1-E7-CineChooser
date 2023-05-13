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
void openApp() async {
  if (firstTime) {
    displayedMovies = await getTopRatedMoviesByGenres(listGenre, 3);
    firstTime = false;
  } else {
    displayedMovies = await getMoviesWithId(displayedMoviesId);
  }
}

Future<bool> loadingDisplayedMovie() async{
  if(displayedMovies.isEmpty){
    return false;
  } else {
    return true;
  }
}




/// Modification de page principale
Future<void> swipeMovie(int id, bool liked) async {
  _justSwiped = true;
  if (liked) {
    likedMovies.add(id);
    db.doc(goodID).update({'likedMovies': likedMovies});
  } else if (!liked) {
    dislikedMovies.add(id);
    db.doc(goodID).update({'dislikedMovies': dislikedMovies});
  }
  lastSwipe = id;


  if (lastSwipe != 0) {
    displayedMoviesId.remove(lastSwipe);
  }
  db.doc(goodID).update({'dislikedMovies': dislikedMovies});

  addRecommendedMovies(id, 3);
  updateDisplayedMoviesId();
}

void onRewind() {
  dislikedMovies.remove(lastSwipe);
  likedMovies.remove(lastSwipe);
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
      if (displayedMovies.elementAt(d).id == similarMovies.elementAt(x).id || likedMovies.contains(similarMovies.elementAt(x).id) || dislikedMovies.contains(similarMovies.elementAt(x).id) ) {
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
  if(likedMovies.isNotEmpty){
    lastLikedMovieId = likedMovies.elementAt(likedMovies.length-1);
  }
  var lastDislikedMovieId = 0;
  if(dislikedMovies.isNotEmpty){
    lastDislikedMovieId = dislikedMovies.elementAt(dislikedMovies.length-1);
  }

  int lastLikedMovieIndex = 0;
  int lastDislikedMovieIndex = 0;

  for(int x = 0; x < displayedMovies.length; x++){
    if(lastLikedMovieId == displayedMovies.elementAt(x).id){
      lastLikedMovieIndex = x;
    }
  }
  for(int y = 0; y < displayedMovies.length; y++){
    if(lastDislikedMovieId == displayedMovies.elementAt(y).id){
      lastDislikedMovieIndex = y;
    }
  }

  int lastIndex = lastDislikedMovieIndex;
  if(lastLikedMovieIndex > lastDislikedMovieIndex){
    lastIndex =lastLikedMovieIndex;
  }
  if(_justSwiped){
    lastIndex+=1;
  }

  for(int i = lastIndex; i < displayedMovies.length; i++){
    newMovieList.add(displayedMovies.elementAt(i));
  }
  _justSwiped = false;

  displayedMovies = newMovieList;
}


/// Update Firebase
updateDisplayedMoviesId() async{
  displayedMoviesId = [];
  for(var movie in displayedMovies){
    if(!(dislikedMovies.contains(movie.id)) && !(likedMovies.contains(movie.id))) {
      displayedMoviesId.add(movie.id);
    }
  }
  db.doc(goodID).update({'displayedMoviesId': displayedMoviesId});
}

friendsMovies() async{
  if(friendList.isNotEmpty){
    for(var friendCode in friendList){

    }
  }
}