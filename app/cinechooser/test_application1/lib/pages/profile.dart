import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
import '../api/movie.dart';
import '../utils/movie_swipe.dart';
import 'login_page.dart';

var likedPosters = [];
var likedNames = [];
var dislikedPosters = [];
var dislikedNames = [];
bool type = true;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

Future addLikedMovies(var moviesId) async {
  Movie movie = await Movie.create(moviesId);
  var poster = movie.poster;
  var name = movie.nom;
  likedPosters.add(poster);
  likedNames.add(name);
}

Future addDislikedMovies(var moviesId) async {
  Movie movie = await Movie.create(moviesId);
  var poster = movie.poster;
  var name = movie.nom;
  dislikedPosters.add(poster);
  dislikedNames.add(name);
}

Future showMovies(var movieId) async {
  for (var id in movieId) {
    Movie movie = await Movie.create(id);
    showedNames.add(movie.nom);
    showedPoster.add(movie.poster);
  }
  return showedPoster;
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PagePrincipale()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Styles.bgColor,
        elevation: 0,
        title: const Text('Your profile', style: Styles.preTitre),
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: width / 9),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 9),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            showLikedMovies();
                            setState(() {});
                          },
                          child: const Text('Liked movies',
                              style: Styles.preTitre)),
                      const SizedBox(width: 100),
                      GestureDetector(
                          onTap: () {
                            showDisLikedMovies();
                            setState(() {});
                          },
                          child: const Text('Disliked movies',
                              style: Styles.preTitre)),
                    ],
                  ),
                ),
                Divider(height: width / 6),
                Center(
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: showMovies(showedList),
                        builder: (context, snaphot) {
                          if (snaphot.hasData) {
                            return Wrap(
                                spacing: width / 9,
                                runSpacing: width / 9,
                                direction: Axis.horizontal,
                                children:
                                    List.generate(showedList.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      changeType(index);
                                      setState(() {});
                                    },
                                    child: MovieSwipe(
                                      id: showedList[index],
                                      poster: showedPoster[index],
                                      name: showedNames[index],
                                    ),
                                  );
                                }));
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showLikedMovies() {
  showedList = likedMovies;
  showedPoster = likedPosters;
  showedNames = likedNames;
  type = true;
}

showDisLikedMovies() {
  showedList = dislikedMovies;
  showedPoster = dislikedPosters;
  showedNames = dislikedNames;
  type = false;
}

changeType(index) {
  if (type) {
    goDisliked(index);
  } else {
    goLiked(index);
  }
}

goDisliked(int index) async {
  dislikedMovies.add(likedMovies[index]);
  likedMovies.remove(likedMovies[index]);
  likedPosters.remove(index);
  likedNames.remove(index);
  db.doc(await goodID).update({'dislikedMovies': dislikedMovies});
  db.doc(await goodID).update({'likedMovies': likedMovies});
}

goLiked(int index) async{
  likedMovies.add(dislikedMovies[index]);
  dislikedMovies.remove(dislikedMovies[index]);
  dislikedMovies.remove(index);
  dislikedMovies.remove(index);
  db.doc(await goodID).update({'dislikedMovies': dislikedMovies});
  db.doc(await goodID).update({'likedMovies': likedMovies});
}
