import 'package:cinechooser/pages/dislikedMovies.dart';
import 'package:cinechooser/pages/likedMovies.dart';
import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
import '../api/movie.dart';
import '../utils/movie_swipe.dart';
import 'login_page.dart';
import '../widget/bottom_navbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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

  int _selectedIndex = 0;

  void navigateBottomBar(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const LikedMovies(),
    const DislikedMovies(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      //bottomNavigationBar: MyBottomNavBar(),
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
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GNav(
            gap: 8,
            color: Styles.grey1,
            activeColor: Styles.white1,
            tabBackgroundColor: Colors.grey.shade900,
            mainAxisAlignment: MainAxisAlignment.center,
            tabBorderRadius: 32,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.all(16),
            onTabChange: (index) {
              navigateBottomBar(index);
            },
            tabs: const [
              GButton(
                icon: Icons.favorite,
                text: 'Like',
              ),
              GButton(
                icon: Icons.heart_broken,
                text: 'Dislike',
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],

        /*body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
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
          )),*/

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
  db.doc(goodID).update({'dislikedMovies': dislikedMovies});
  db.doc(goodID).update({'likedMovies': likedMovies});
}

goLiked(int index) async {
  likedMovies.add(dislikedMovies[index]);
  dislikedMovies.remove(dislikedMovies[index]);
  dislikedMovies.remove(index);
  dislikedMovies.remove(index);
  db.doc(goodID).update({'dislikedMovies': dislikedMovies});
  db.doc(goodID).update({'likedMovies': likedMovies});
}
