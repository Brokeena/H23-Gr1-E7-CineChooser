import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'login_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}


class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return ValueListenableBuilder<bool>(
      valueListenable: hasData,
      builder: (context, value, child) {
        if (value == true) {
          return const PagePrincipale();
        } else {
          return Scaffold(
            backgroundColor: Styles.bgColor,
            body: Center(
              child: SpinKitThreeBounce(
                size: width/10,
                color: Styles.red1,
                duration: const Duration(seconds: 1),
              ),
            ),
          );
        }
      },
    );

  }
}

