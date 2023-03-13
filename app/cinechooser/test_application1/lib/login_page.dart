// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{

  final List<String> urlImages = [
    'https://image.tmdb.org/t/p/original/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg',
    'https://image.tmdb.org/t/p/original/rtGDOeG9LzoerkDGZF9dnVeLppL.jpg',
    'https://image.tmdb.org/t/p/original/kve20tXwUZpu4GUX8l6X7Z4jmL6.jpg',
    'https://image.tmdb.org/t/p/original/74xTEgt7R36Fpooo50r9T25onhq.jpg',
    'https://image.tmdb.org/t/p/original/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                CarouselSlider(
                    items: urlImages.map((item) => Container(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            ),
                        )
                      ),
                    )).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      reverse: true,
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      aspectRatio: 1.0
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
                color: Colors.red,
              ),),

                const Icon(
                  Icons.live_tv,
                  size: 100,
                  color: Colors.white,
                ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
               const Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                 child: Text(
                  'CineChooser recommande des films en fonction de vos '
                      'critères et aide vos amis à trouver un film qui plait à '
                      'tous. Découvrez de nouveaux films passionnants à '
                      'regarder ensemble ! test push',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white38,
                  ),),
               ),

              //continue button
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 25),
                   child: Container(
                     padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.arrow_right, color: Colors.white),
                          const SizedBox(width: 8,),
                          const Text(
                            'Continuer',
                            style: TextStyle(
                              fontWeight:  FontWeight.w800,
                              fontSize: 20,
                              color: Colors.white,),
                            ),
                        ],
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