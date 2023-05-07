import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:cinechooser/utils/movie_swipe.dart';
import 'package:cinechooser/widget/MovieCase.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/services.dart';
import '../api/movie.dart';
import 'login_page.dart';

var likedPosters = [];
var likedNames = [];
var dislikedPosters = [];
var dislikedNames = [];

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
                        child:
                            const Text('Liked movies', style: Styles.preTitre)),
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
              Center(
                child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    direction: Axis.horizontal,
                    children: List.generate(showedList.length, (index) {
                      return Text(showedList[index].toString(),
                          style: Styles.preTitre);
                    }))
                /*Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    direction: Axis.horizontal,
                    children: List.generate(likedMovies.length, (index) {
                      return MovieCase(
                          onPressed: goDisliked(index),
                          nom: likedNames[index],
                          image: likedPosters[index]);
                    }))
                      */
                ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showLikedMovies() {
  showedList = likedMovies;
}

showDisLikedMovies() {
  showedList = dislikedMovies;
}

goDisliked(int index) {
  dislikedMovies.add(index);
  likedMovies.remove(index);
  likedPosters.remove(index);
  likedNames.remove(index);
}

goLiked(int index) {
  likedMovies.add(index);
  dislikedMovies.remove(index);
  dislikedMovies.remove(index);
  dislikedMovies.remove(index);
}
