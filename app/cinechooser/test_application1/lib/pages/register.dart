// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cinechooser/widget/button_carre.dart';
import 'package:cinechooser/widget/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinechooser/api/api.dart';
import 'package:cinechooser/pages/setup_utilisateur.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinechooser/main.dart';
import 'package:cinechooser/utils/app_styles.dart';

import 'choix.dart';

class RegisterPage extends StatefulWidget {

  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<String> urls = [];

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
    buttonPressed();
  }



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


  void signUp

  @override
  void dispose()
  {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
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
                                  height: height*0.4
                              ));
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),

                  /*
                  SizedBox(
                      height: height * 0.03), //s'adapte a differentes tailles
                  const AutoSizeText(
                    'Bienvenue sur',
                    style: Styles.preTitre,
                    maxLines: 1,
                  ),

                  const AutoSizeText('CineChooser', style: Styles.titre,maxLines: 1,),

                   Icon(
                    Icons.live_tv,
                    size: height*0.1,
                    color: Colors.white,
                  ),

                  SizedBox(height: height * 0.01),
                  //texte de bienvenue
                   Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.01),
                    child: const AutoSizeText (
                        'CineChooser recommande des films en fonction de vos '
                        'critères et aide votre groupe à trouver un film qui plait à '
                        'tous. Découvrez de nouveaux films passionnants à '
                        'regarder ensemble !',
                        maxLines: 3,
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
                   */

                  SizedBox(height: height * 0.05),

                  MyTextField(
                      controller: _emailController,
                      hintText: "Email",
                      obscureText: false),

                  SizedBox(height: height * 0.01),

                  MyTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      obscureText: true),

                  SizedBox(height: height * 0.01),

                  // Boutton Commencer
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: width*0.05),
                    child: GestureDetector(
                      onTap: signUp,
                      //(){_navigateToNextScreen(context);},
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        padding: EdgeInsets.all(width*0.04),
                        decoration: BoxDecoration(
                          color: Styles.red2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //const Icon(CupertinoIcons.arrow_right, color: Color(0xffC4C0CA)),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text('Sign Up', style: TextStyle(
                                color: Styles.white1,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),)

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already a member ?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const Text(' login now', style: TextStyle( color: Colors.blue, fontWeight: FontWeight.bold), )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
