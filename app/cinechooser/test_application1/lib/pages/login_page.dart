import 'package:cinechooser/pages/loading_page.dart';
import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:cinechooser/pages/reglages.dart';
import 'package:cinechooser/widget/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinechooser/api/api.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinechooser/main.dart';
import 'package:cinechooser/utils/app_styles.dart';
import '../api/algorithm.dart';
import '../api/movie.dart';
import 'forgotPassewordPage.dart';

var docID = '';
var db = FirebaseFirestore.instance.collection('users');
String paysSelectionne = 'Country';
String paysISO = 'CA';
List<dynamic> selectedItems = [];
List<dynamic>? results = [];
List<dynamic> likedMoviesId = [];
List<dynamic> dislikedMoviesId = [];
List<dynamic> displayedMoviesId = [];
List<dynamic> listGenre = [];
List<dynamic> friendList = [];
var showedPoster = [];
var showedNames = [];
bool firstTime = false;
var friendCode = '';
late ValueNotifier<bool> hasData = ValueNotifier(false);
List<Movie> likedMovies = [];
List<Movie> dislikedMovies = [];

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

initiateALl() async {
  hasData.value = false;
  var collectionReference = db.doc(await getActualUserDocId()).get();
  collectionReference.then((collection) {
    var data = collection.data() as Map<String, dynamic>;
    paysSelectionne = data['pays'];
    selectedItems = data['providers'];
    likedMoviesId = data['likedMovies'];
    dislikedMoviesId = data['dislikedMovies'];
    listGenre = data['genres'];
    firstTime = data['firstTime'];
    displayedMoviesId = data['displayedMoviesId'];
    docID = data['docID'];
    friendList = data['friendList'];
    friendCode = data['docID'];
  }).then((value) async {
    await openApp();
    openApp().then((value) async {
      hasData.value = true;
      print("HAS DATA");
      for (int l = 0; l < likedMoviesId.length; l++) {
        likedMovies.add(await Movie.create(likedMoviesId.elementAt(l)));
      }
      for (int d = 0; d < dislikedMoviesId.length; d++) {
        dislikedMovies.add(await Movie.create(dislikedMoviesId.elementAt(d)));
      }
    });
  });
}

getActualUserDocId() async {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = await getDocId();
  var db = FirebaseFirestore.instance.collection('users');

  String docID = 'empty';
  for (var documentId in docIDs) {
    var collectionReference = await db.doc(documentId).get();
    var data = collectionReference.data() as Map<String, dynamic>;

    if (data['userID'] == user.uid) {
      docID = data['docID'];
    }
  }
  return docID;
}

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<String> urls = [];

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signin() async {
    hasData.value = false;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      initiateALl();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const LoadingPageLogin()));
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  void dispose() {
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
                                  autoPlayInterval: const Duration(
                                      seconds: 3, milliseconds: 500),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  aspectRatio: 1,
                                  height: height * 0.4));
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                  SizedBox(height: height * 0.03),
                  //s'adapte a differentes tailles
                  const AutoSizeText(
                    'Welcome to',
                    style: Styles.preTitre,
                    maxLines: 1,
                  ),

                  const AutoSizeText('CineChooser',
                      style: Styles.titre, maxLines: 1),

                  SizedBox(height: height * 0.01),

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

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ForgotPasswordPage();
                              }));
                            },
                            child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.01),

                  // Boutton Commencer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: GestureDetector(
                      onTap: signin,
                      //(){_navigateToNextScreen(context);},
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        padding: EdgeInsets.all(width * 0.04),
                        decoration: BoxDecoration(
                          color: Styles.red2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Sign In',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Styles.white1,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
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
                      const Text('Not a member ?',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: const Text(
                            ' Register now',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
