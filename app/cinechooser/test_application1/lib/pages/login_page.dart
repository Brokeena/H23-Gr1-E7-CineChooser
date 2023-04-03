// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinechooser/api/api.dart';
import 'package:cinechooser/pages/setup_utilisateur.dart';
import 'package:cinechooser/main.dart';
import 'package:cinechooser/utils/app_styles.dart';

import 'choix.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<String> urls = [];

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Choix()));
  }

  bool isButtonPressed = false;

  void buttonPressed() {
    setState(() {
      if (isButtonPressed == false) {
        isButtonPressed = true;
        Future.delayed(const Duration(milliseconds: 100), () {
          _navigateToNextScreen(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<List<String>?>(
                    future: getTrendingMoviesImages(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        urls = snapshot.data!;
                        urls.add(poster);
                        return CarouselSlider(
                            items: urls
                                .map((item) => Center(
                                        child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      child: Image.network(
                                        item,
                                        fit: BoxFit.cover,
                                      ),
                                    )))
                                .toList(),
                            options: CarouselOptions(
                              scrollPhysics: NeverScrollableScrollPhysics(),
                              autoPlay: true,
                              enlargeCenterPage: true,
                              reverse: false,
                              autoPlayInterval:
                                  Duration(seconds: 3, milliseconds: 500),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              aspectRatio: 1,
                            ));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),

                SizedBox(
                    height: height * 0.03), //s'adapte a differentes tailles
                const Text(
                  'Bienvenue sur',
                  style: Styles.preTitre,
                ),

                const Text('CineChooser', style: Styles.titre),

                const Icon(
                  Icons.live_tv,
                  size: 100,
                  color: Colors.white,
                ),

                SizedBox(height: height * 0.01),
                //texte de bienvenue
                 Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.01),
                  child: const Text(
                      'CineChooser recommande des films en fonction de vos '
                      'critères et aide votre groupe à trouver un film qui plait à '
                      'tous. Découvrez de nouveaux films passionnants à '
                      'regarder ensemble !',
                      textAlign: TextAlign.center,
                      style: Styles.informations),
                ),
                SizedBox(height: height * 0.01),
                // Boutton Commencer
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width*0.05),
                  child: GestureDetector(
                    onTap: buttonPressed,
                    //(){_navigateToNextScreen(context);},
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      padding: EdgeInsets.all(width*0.04),
                      decoration: BoxDecoration(
                          color: Styles.bgColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isButtonPressed
                              ? [
                                  //aucune ombre
                                ]
                              : [
                                  const BoxShadow(
                                    color: Color(0xff1C1825),
                                    offset: Offset(4, 4),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                  const BoxShadow(
                                    color: Color(0xff1C1825),
                                    offset: Offset(-4, -4),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  )
                                ]),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //const Icon(CupertinoIcons.arrow_right, color: Color(0xffC4C0CA)),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text('Commencer', style: Styles.bouton),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
