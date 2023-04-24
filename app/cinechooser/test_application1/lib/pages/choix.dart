import 'package:cinechooser/pages/login_page.dart';
import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:cinechooser/pages/reglages.dart';
import 'package:cinechooser/pages/reglages_first_time.dart';
import 'package:cinechooser/pages/setup_utilisateur.dart';
import 'package:cinechooser/widget/button_carre.dart';
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
                          image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtRpDp4tZLAMkZLHFbakQUq8gmyK3A1AX6QA&usqp=CAU',
                          onPressed: () {
                            listGenre.add(12);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Animation',
                          image:  'data:image/jpeg;base64,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',
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
                        image: 'data:image/jpeg;base64,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',
                        onPressed: () {
                          listGenre.add(35);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Crime',
                          image: 'https://orion-uploads.openroadmedia.com/md_81afe139738e-cimemovies_sicario.jpg',
                              onPressed: () {
                            listGenre.add(80);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Documentary',
                          image: 'https://media.globalcitizen.org/thumbnails/d1/e1/d1e1f2de-8f4c-410f-82a2-84ce81adf597/ourplanet_netflix_stills_012.jpg__1600x900_q85_crop_subsampling-2.jpg',
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
                            'data:image/jpeg;base64,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',onPressed: () {
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
