import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:cinechooser/pages/R%C3%A9glages/reglages_first_time.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../pages/Connexions/login_page.dart';

class LoadingPageLogin extends StatefulWidget {
  const LoadingPageLogin({Key? key}) : super(key: key);

  @override
  State<LoadingPageLogin> createState() => _LoadingPageLoginState();
}

class _LoadingPageLoginState extends State<LoadingPageLogin> {
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
                size: width / 10,
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

class LoadingPageRegister extends StatefulWidget {
  const LoadingPageRegister({Key? key}) : super(key: key);

  @override
  State<LoadingPageRegister> createState() => _LoadingPageRegisterState();
}

class _LoadingPageRegisterState extends State<LoadingPageRegister> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return ValueListenableBuilder<bool>(
      valueListenable: hasData,
      builder: (context, value, child) {
        if (value == true) {
          return const ReglagesFirstTime();
        } else {
          return Scaffold(
            backgroundColor: Styles.bgColor,
            body: Center(
              child: SpinKitThreeBounce(
                size: width / 10,
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
