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
  List<String> listGenre = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
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
                    backgroundColor: Styles.red1,),
                child: const Text('Suivant', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReglagesFirstTime()),
                  );
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
                const Text('Choisissez 5 genres ou plus ',
                    style: Styles.informations),
                const Divider(height: 25),
                Row(
                  children: [
                    MovieCase(
                        nom: 'Action',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add('Action');
                          print('action');
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Aventure',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Aventure');
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Comédie',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Comédie');
                          }),
                    ),
                  ],
                ),
                Divider(height: width / 16),
                Row(
                  children: [
                    MovieCase(
                        nom: 'Action',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add('Action');
                          print('action');
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Aventure',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Aventure');
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Comédie',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Comédie');
                          }),
                    ),
                  ],
                ),
                Divider(height: width / 16),
                Row(
                  children: [
                    MovieCase(
                        nom: 'Action',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add('Action');
                          print('action');
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Aventure',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Aventure');
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Comédie',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Comédie');
                          }),
                    ),
                  ],
                ),
                Divider(height: width / 16),
                Row(
                  children: [
                    MovieCase(
                        nom: 'Action',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add('Action');
                          print('action');
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Aventure',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Aventure');
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Comédie',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Comédie');
                          }),
                    ),
                  ],
                ),
                Divider(height: width / 16),
                Row(
                  children: [
                    MovieCase(
                        nom: 'Action',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add('Action');
                          print('action');
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Aventure',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Aventure');
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Comédie',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Comédie');
                          }),
                    ),
                  ],
                ),
                Divider(height: width / 16),
                Row(
                  children: [
                    MovieCase(
                        nom: 'Action',
                        image:
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                        onPressed: () {
                          listGenre.add('Action');
                          print('action');
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Aventure',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Aventure');
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Comédie',
                          image:
                              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/keanu-reeves-john-wick-4-1668099111.jpg?crop=0.716xw:1.00xh;0.284xw,0&resize=1200:*',
                          onPressed: () {
                            listGenre.add('Comédie');
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
