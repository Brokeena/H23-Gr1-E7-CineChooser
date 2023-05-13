import 'package:cinechooser/pages/reglages.dart';
import 'package:flutter/material.dart';
import '../utils/app_styles.dart';
import '../widget/friend.dart';
import 'login_page.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Scaffold build(BuildContext context)  {
    double width = MediaQuery.of(context).size.width;
    print('friendsList :$friendList');
    return Scaffold(
        backgroundColor: Styles.bgColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Friends', style: Styles.entete),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Reglages()),
              );
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.white),
          ),
        ),
        body: SafeArea(child:  Wrap(
            spacing: width / 16,
            runSpacing: width / 16,
            direction: Axis.horizontal,
            children: List.generate(friendList.length, (index) {
              print(friendList);
              return Friend(id:friendList[index]);
            })),)
    );
  }
}
