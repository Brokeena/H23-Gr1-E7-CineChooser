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
      padding: EdgeInsets.only(left: width / 4),

        child :
          AutoSizeText(
            maxLines: 1,
            pseudos[index],
            style: Styles.titre,
          )
    );
  }
}
