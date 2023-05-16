import 'package:cinechooser/pages/friendList.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:cinechooser/pages/login_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinechooser/pages/catalogue.dart';

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
          children: friendListName.map((name) {
            int pos = 0;
            for(int x =0; x < friendListName.length;x++){
              if(name == friendListName.elementAt(x)){
                pos = x;
              }
            }
            //liste amis
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    name,
                    style: Styles.preTitre,
                  ),
                ),
                SizedBox(
                  height: width/2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: friendListLike.elementAt(pos).reversed.map((movie) { // liste de films des amis
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

