import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../pages/friendList.dart';
import '../pages/login_page.dart';

class Friend extends StatelessWidget {
  const Friend({required this.index, Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(left: width / 20),
        child: Row(
          children: [
            AutoSizeText(
              maxLines: 1,
              pseudos[index],
              style: Styles.preTitre,
            ),
            SizedBox(width: width / 40),
            ElevatedButton(
              onPressed: () async {
                await unfriend(index);
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(),
                  fixedSize: Size(width / 19, width / 19),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  shape: const StadiumBorder()),
              child: Icon(Icons.group_remove,
                  color: Styles.red1, size: width / 19),
            ),
          ],
        )
    );
  }
}

unfriend(index) async {
  var data = await db.doc(friendList[index]).get();
  var friendListAmi = data['friendList'];
  friendListAmi.remove(docID);
  await db.doc(friendList[index]).update({'friendList': friendListAmi});

  friendList.remove(friendList[index]);
  db.doc(docID).update({'friendList': friendList});
}