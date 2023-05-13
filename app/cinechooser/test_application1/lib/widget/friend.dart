import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';

String pseudo = '';

class Friend extends StatelessWidget {
  const Friend({required this.id, Key? key}) : super(key: key);

  final String id;

  getFriendPseudo() async {
    var data = await db.doc(id).get();
    pseudo = data['pseudo'];
    print(pseudo);
    return pseudo;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFriendPseudo(),
      builder: (context, snaphot) {
        if (snaphot.hasData) {
          return AutoSizeText(maxLines: 1, pseudo, style: Styles.titre,);
        } else {
          return const CircularProgressIndicator();
        }
      }
    );
  }
}
