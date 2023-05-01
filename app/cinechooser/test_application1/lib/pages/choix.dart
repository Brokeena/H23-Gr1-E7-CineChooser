

import 'package:cinechooser/pages/login_page.dart';
import 'package:cinechooser/pages/main_page.dart';
import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:cinechooser/pages/reglages.dart';
import 'package:cinechooser/pages/reglages_first_time.dart';
import 'package:cinechooser/pages/setup_utilisateur.dart';
import 'package:cinechooser/widget/button_carre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:cinechooser/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widget/MovieCase.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
List<int> listGenre = [];

class Choix extends StatefulWidget {
  const Choix({Key? key}) : super(key: key);

  @override
  State<Choix> createState() => _ChoixState();
}

  updateUserDetails(List<int> genres) async {

    var firebase;
    var db = firebase.firestore();

    db.collection("users").doc('ZqMQ8bMY0L1uZvsV9rIW').update({ 'genres ': listGenre});
    print('update');
}
  

class _ChoixState extends State<Choix> {

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
            if (listGenre.length >= 3) {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
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
                    print(listGenre);
                    updateUserDetails(listGenre);
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
                        image: imageGenre.elementAt(0),
                        onPressed: () {
                          listGenre.add(28);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Adventure',
                          image: imageGenre.elementAt(1),
                          onPressed: () {
                            listGenre.add(12);
                            print(listGenre);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Animation',
                          image:  imageGenre.elementAt(2),
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
                        image: imageGenre.elementAt(3),
                        onPressed: () {
                          listGenre.add(35);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Crime',
                          image: imageGenre.elementAt(4),
                              onPressed: () {
                            listGenre.add(80);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Documentary',
                          image: imageGenre.elementAt(5),
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
                        image: imageGenre.elementAt(6),
                        onPressed: () {
                          listGenre.add(18);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Family',
                          image: imageGenre.elementAt(7),
                          onPressed: () {
                            listGenre.add(10751);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Fantasy',
                          image: imageGenre.elementAt(8),
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
                        image: imageGenre.elementAt(9),
                        onPressed: () {
                          listGenre.add(36);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Horror',
                          image: imageGenre.elementAt(10),
                          onPressed: () {
                            listGenre.add(27);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Music',
                          image: imageGenre.elementAt(11),
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
                        image: imageGenre.elementAt(12),
                        onPressed: () {
                          listGenre.add(9648);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Romance',
                          image: imageGenre.elementAt(13),
                          onPressed: () {
                            listGenre.add(10749);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Science fiction',
                          image: imageGenre.elementAt(14),
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
                        image: imageGenre.elementAt(15),
                        onPressed: () {
                          listGenre.add(53);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'War',
                          image: imageGenre.elementAt(16),
                          onPressed: () {
                            listGenre.add(10752);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 16),
                      child: MovieCase(
                          nom: 'Western',
                          image: imageGenre.elementAt(17),
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
