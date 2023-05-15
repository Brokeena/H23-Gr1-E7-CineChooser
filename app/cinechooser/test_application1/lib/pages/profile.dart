import 'package:cinechooser/pages/dislikedMovies.dart';
import 'package:cinechooser/pages/likedMovies.dart';
import 'package:cinechooser/pages/friendsLikedMovies.dart';
import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
import '../api/algorithm.dart';
import '../api/movie.dart';
import '../utils/movie_swipe.dart';
import 'login_page.dart';
import '../widget/bottom_navbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

List<String> friendListName = [];
List<List<Movie>> friendListLike = [];
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
/*
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

 */

class _ProfileState extends State<Profile> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    if(index == 1){
      getFriendsNames();
      getSimilarsMoviesLikedPerFriend();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const LikedMovies(),
    const FriendLikedMovies(),
    const DislikedMovies(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: MyBottomNavBar(),
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            trimDisplayedMovie();
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
                icon: Icons.diversity_1,
                text: 'Friends',
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
    );
  }
}

getSimilarsMoviesLikedPerFriend() async{
  if(friendList.isNotEmpty){
    for(var friend in friendList){
      friendListLike.add(await similarLike(friend.toString()));
    }
  }
}

getFriendsNames() async{
  List<String> tempList = [];
  for (var friendCode in friendList) {
    var data = await db.doc(friendCode.toString()).get();
    var friendName = data['pseudo'];
    if(!(friendListName.contains(friendName))){
      friendListName.add(friendName);
    }
    tempList.add(friendName);
  }
  List<String> elementsToRemove = [];
  for(int t = 0; t < friendListName.length;t++){
    if(!(tempList.contains(friendListName.elementAt(t)))){
      elementsToRemove.add(friendListName.elementAt(t));
    }
  }
  for(var element in elementsToRemove){
    friendListName.remove(element);
  }


}
