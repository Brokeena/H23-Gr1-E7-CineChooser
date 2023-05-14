import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinechooser/pages/reglages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_styles.dart';
import '../widget/friend.dart';
import '../widget/textField.dart';
import 'login_page.dart';

List<String> pseudos = [];
final _addFriends = TextEditingController();

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Scaffold build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Row(
                    children: [
                      AutoSizeText(
                          maxLines: 1,
                          'Your friendcode :   $friendCode',
                          style: Styles.petittitres),
                      SizedBox(width: width / 40),
                      ElevatedButton(
                          onPressed: _copy(),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(),
                              fixedSize: Size(width / 19, width / 19),
                              elevation: 0,
                              backgroundColor: Colors.white,
                              shape: const StadiumBorder()),
                          child: Icon(Icons.copy,
                              color: Styles.red1, size: width / 19))
                    ],
                  ),
                ),
                Divider(height: height / 30),
                MyTextField(
                    controller: _addFriends,
                    hintText: "Add friends with their code",
                    obscureText: false),
                Divider(height: height / 50),
                Padding(
                  padding: EdgeInsets.only(left: width / 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      await _addFriend();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(),
                        fixedSize: Size(width / 19, width / 19),
                        elevation: 0,
                        backgroundColor: Colors.white,
                        shape: const StadiumBorder()),
                    child: Icon(Icons.group_add,
                        color: Styles.red1, size: width / 19),
                  ),
                ),
                Divider(height: height / 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: const AutoSizeText(
                      maxLines: 1,
                      'Your friends : ',
                      style: Styles.petittitres),
                ),
                Divider(height: height / 40),
                SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            future: getFriendsPseudo(),
                            builder: (context, snaphot) {
                              if (snaphot.hasData) {
                                return Wrap(
                                    spacing: width / 20,
                                    runSpacing: width / 20,
                                    direction: Axis.vertical,
                                    children:
                                        List.generate(friendList.length, (index) {
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Friend(index: index),
                                          SizedBox(width: width / 40),
                                          ElevatedButton(
                                            onPressed: () async {
                                              setState(() {
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(),
                                                fixedSize: Size(width / 19, width / 19),
                                                elevation: 0,
                                                backgroundColor: Colors.transparent,
                                                shape: const StadiumBorder()),
                                            child: Icon(Icons.group_remove,
                                                color: Colors.transparent, size: width / 19),
                                          ),

                                        ],
                                      );
                                    }));
                              } else {
                                return const CircularProgressIndicator();
                              }
                            }),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}



getFriendsPseudo() async {
  for (var friendId in friendList) {
    var data = await db.doc(friendId).get();
    var pseudo1 = await data['pseudo'];
    pseudos.add(pseudo1);
  }
  return pseudos;
}

userExiste() async {
  List<String> docIDs = await getDocId();

  for (var documentId in docIDs) {
    var collectionReference = await db.doc(documentId).get();
    var data = collectionReference.data() as Map<String, dynamic>;
    if (data['docID'] == _addFriends.text.trim().toString()) {
      for (var friend in friendList) {
        if (friend == _addFriends.text.trim()) {
          print('already friends');
          return false;
        }
      }
      print('existe');
      return true;
    }
  }
  print('friend code doesnt exist');
  return false;
}

_addFriend() async {
  var data = await db.doc(_addFriends.text.trim().toString()).get();
  var friendListAmi = data['friendList'];
  if ((_addFriends.text.trim().toString() != docID) && await userExiste()) {
    friendListAmi.add(docID);
    friendList.add(_addFriends.text.trim());
    db.doc(docID).update({'friendList': friendList});
    db
        .doc(_addFriends.text.trim().toString())
        .update({'friendList': friendListAmi});
    return true;
  } else {
    return false;
  }
}

_copy() {
  var value = ClipboardData(text: friendCode);
  Clipboard.setData(value);
}
