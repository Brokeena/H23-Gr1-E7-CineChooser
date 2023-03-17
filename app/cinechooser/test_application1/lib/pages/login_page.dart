// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:test_application1/pages/setup_utilisateur.dart';
import 'package:test_application1/pages/main.dart';
import 'package:test_application1/utils/app_styles.dart';


class LoginPage extends StatefulWidget
{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{

  List<String> url = [];
  void main() async{
    url = await getImages();
  }

  final List<String> urlImages = [
    'https://image.tmdb.org/t/p/original/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg',
    'https://image.tmdb.org/t/p/original/rtGDOeG9LzoerkDGZF9dnVeLppL.jpg',
    'https://image.tmdb.org/t/p/original/kve20tXwUZpu4GUX8l6X7Z4jmL6.jpg',
    'https://image.tmdb.org/t/p/original/74xTEgt7R36Fpooo50r9T25onhq.jpg',
    'https://image.tmdb.org/t/p/original/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg',
  ];



  void _navigateToNextScreen(BuildContext context)
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SetupUtilisateur()));
  }

  bool isButtonPressed = false;
  void buttonPressed()
  {
    setState(() {
      if(isButtonPressed == false)
      {
        isButtonPressed = true;
        Future.delayed(const Duration(milliseconds: 100), () {
          _navigateToNextScreen(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                CarouselSlider(
                    items: url.map((item) => Container(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            ),
                        )
                      ),
                    )).toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      reverse: true,
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      aspectRatio: 1,
                    )),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03), //s'adapte a differentes tailles
                const Text(
                  'Bienvenue sur',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),

               const Text(
                  'CineChooser',
              style:  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: Styles.red2,
              ),),

                const Icon(
                  Icons.live_tv,
                  size: 100,
                  color: Colors.white,
                ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
               //texte de bienvenue
               const Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                 child: Text(
                  'CineChooser recommande des films en fonction de vos '
                      'critères et aide votre groupe à trouver un film qui plait à '
                      'tous. Découvrez de nouveaux films passionnants à '
                      'regarder ensemble !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white38,
                  ),),
               ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                // Boutton Commencer
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 25),
                   child: GestureDetector(
                     onTap: buttonPressed,
                         //(){_navigateToNextScreen(context);},
                       child: AnimatedContainer(
                         duration: Duration(milliseconds: 100),
                           padding: EdgeInsets.all(15),
                           decoration: BoxDecoration(
                               color: Styles.bgColor,
                               borderRadius: BorderRadius.circular(12),
                               boxShadow: isButtonPressed ?
                               [
                                 //aucune ombre
                                ]:
                               [
                             const BoxShadow(
                               color: Colors.black,
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
                       const SizedBox(width: 8,),
                       const Text(
                       'Commencer',
                       style: TextStyle(
                       fontWeight:  FontWeight.w800,
                       fontSize: 20,
                       color: Styles.red1,),
                       ),
                          ],
                        ),
                      ),
                     ),
                   ),
                 )
            ],),
          ),
        ),
      )
    );
  }


}