import 'package:cinechooser/pages/friendList.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:cinechooser/pages/login_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FriendLikedMovies extends StatefulWidget {
  const FriendLikedMovies({Key? key}) : super(key: key);

  @override
  State<FriendLikedMovies> createState() => _FriendLikedMoviesState();
}

class _FriendLikedMoviesState extends State<FriendLikedMovies> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: likedMovies.map((movie) { //liste amis
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Friends',
                    style: Styles.preTitre,
                  ),
                ),
                SizedBox(
                  height: width/2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: likedMovies.reversed.map((movie) { // liste de films des amis
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/50),
                          child: Container(
                            width: width / 3,
                            height: width / 2,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(movie.poster, maxWidth: width~/3, maxHeight: width~/2),
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

getFriendsPseudo() async {
  pseudos = [];
  for (var friendId in friendList) {
    var data = await db.doc(friendId).get();
    var pseudo1 = await data['pseudo'];
    pseudos.add(pseudo1);
  }
  return pseudos;
}
