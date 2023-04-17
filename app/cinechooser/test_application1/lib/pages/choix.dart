import 'package:cinechooser/pages/login_page.dart';
import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:cinechooser/pages/reglages.dart';
import 'package:cinechooser/pages/reglages_first_time.dart';
import 'package:cinechooser/pages/setup_utilisateur.dart';
import 'package:cinechooser/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';

import '../widget/MovieCase.dart';

class Choix extends StatefulWidget {
  const Choix({Key? key}) : super(key: key);

  @override
  State<Choix> createState() => _ChoixState();
}

class _ChoixState extends State<Choix> {
  List<int> listGenre = [];

  @override
  Widget build(BuildContext context) {
    print(listGenre);
    print("choiz page");
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (listGenre.length >= 5) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Styles.red1,
                ),
                child: const Text('Suivant',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  if (listGenre.length >= 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReglagesFirstTime()),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: width / 16, left: width / 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 25),
                const Text('Bienvenue sur CineChooser',
                    style: Styles.nom_de_pages),
                const Divider(height: 10),
                const Text('Choisissez 3 genres ou plus ',
                    style: Styles.informations),
                const Divider(height: 25),
                Row(
                  children: [
                    MovieCase(
                        nom: 'Action',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add(28);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Adventure',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(12);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Animation',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(16);
                          }),
                    ),
                  ],
                ),
                Divider(height: width / 16),
                Row(
                  children: [
                    MovieCase(
                        nom: 'Comedy',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add(35);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Crime',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(80);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Documentary',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(99);
                          }),
                    ),
                  ],
                ),
                Divider(height: width / 16),
                Row(
                  children: [
                    MovieCase(
                        nom: 'Drama',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add(18);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Family',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(10751);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Fantasy',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(14);
                          }),
                    ),
                  ],
                ),
                Divider(height: width / 16),
                Row(
                  children: [
                    MovieCase(
                        nom: 'History',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add(36);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Horror',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(27);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Music',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(10402);
                          }),
                    ),
                  ],
                ),
                Divider(height: width / 16),
                Row(
                  children: [
                    MovieCase(
                        nom: 'Mystery',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add(9648);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Romance',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(10749);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Science fiction',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(878);
                          }),
                    ),
                  ],
                ),
                Divider(height: width / 16),
                Row(
                  children: [
                    MovieCase(
                        nom: 'Thriller',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add(53);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'War',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(10752);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Western',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add(37);
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
