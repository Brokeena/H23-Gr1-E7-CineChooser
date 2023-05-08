import 'package:cinechooser/pages/auth_page.dart';
import 'package:cinechooser/pages/reglages_first_time.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:cinechooser/main.dart';
import '../widget/MovieCase.dart';
import 'package:cinechooser/pages/login_page.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
List<dynamic> listGenre = [];
double tailleBordure = 0;

class Choix extends StatefulWidget {
  const Choix({Key? key}) : super(key: key);

  @override
  State<Choix> createState() => _ChoixState();
}

Future getDocId() async {
  List<String> docIDs = [];
  await FirebaseFirestore.instance
      .collection('users')
      .get()
      .then((snapshot) => snapshot.docs.forEach((document) {
            docIDs.add(document.reference.id);
          }));
  return docIDs;
}


Future deleteUser() async {
//delete the just created user
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AuthPage()),
            );
            deleteUser();
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
                onPressed: () async {
                  if (listGenre.length >= 3) {

                    db.doc(await goodID).update({'genres': listGenre});

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  const ReglagesFirstTime()),
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
                Wrap(
                    spacing: width / 16,
                    runSpacing: width / 16,
                    direction: Axis.horizontal,
                    children: List.generate(idGenre.length, (index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectionne[index]) {
                                listGenre.add(idGenre[index]);
                                colors[index] = Colors.white;
                                selectionne[index] = false;
                              } else {
                                listGenre.remove(idGenre[index]);
                                colors[index] = Colors.transparent;
                                selectionne[index] = true;
                              }
                            });
                          },
                          child: MovieCase(
                              nom: nomGenre[index],
                              image: imageGenre[index],
                              color: colors[index]));
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
