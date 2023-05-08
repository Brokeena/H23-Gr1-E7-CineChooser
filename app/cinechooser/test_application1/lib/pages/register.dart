import 'package:cinechooser/widget/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
  bool isButtonPressed = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _latNameController = TextEditingController();
  final _ageController = TextEditingController();

  Future signUp() async {
    if (passwordValide() && ageValide()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        addUserDetails(
            _nameController.text.trim(),
            _latNameController.text.trim(),
            _emailController.text.trim(),
            int.parse(_ageController.text.trim()));
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Choix()));
      } on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            });
      }


    } else {
      if (!passwordValide()) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('The password is not matching'),
              );
            });
      }
      if (!ageValide()) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('Your age is not valide'),
              );
            });
      }
    }
  }

  Future addUserDetails(
      String firstName, String lastName, String email, int age) async {
    String docId = "";
    await FirebaseFirestore.instance.collection('users').add({
      'first name': lastName,
      'last name': firstName,
      'age': age,
      'email': email,
      'genres': [],
      'dislikedMovies' : [],
      'likedMovies' : []
    }).then((DocumentReference doc) {
      docId = doc.id;
    });

    var db = await FirebaseFirestore.instance;

    final user = FirebaseAuth.instance.currentUser!;

    db.collection("users").doc(docId).update({'userID': user.uid});

    db.collection("users").doc(docId).update({'docID': docId});
  }

  bool passwordValide() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  bool ageValide() {
    try {
      if (int.parse(_ageController.text.trim()) < 100 &&
          int.parse(_ageController.text.trim()) > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e){
      return false;
    }

  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _latNameController.dispose();
    _ageController.dispose();
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
                  SizedBox(height: height * 0.03),
                  const AutoSizeText(
                    'Welcome to',
                    style: Styles.preTitre,
                    maxLines: 1,
                  ),
                  const AutoSizeText(
                    'CineChooser',
                    style: Styles.titre,
                    maxLines: 1,
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.01),
                    child: const AutoSizeText(
                        'CineChooser recommends movies based on your criteria '
                        'and helps your group find a film that everyone will'
                        ' enjoy. Discover new and exciting movies '
                        'to watch together!',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: Styles.informations),
                  ),
                  SizedBox(height: height * 0.05),
                  MyTextField(
                      controller: _nameController,
                      hintText: "Name",
                      obscureText: false),
                  SizedBox(height: height * 0.01),
                  MyTextField(
                      controller: _latNameController,
                      hintText: "Last name",
                      obscureText: false),
                  SizedBox(height: height * 0.01),
                  MyTextField(
                      controller: _ageController,
                      hintText: "Age",
                      obscureText: false),
                  SizedBox(height: height * 0.01),
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
                  MyTextField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm password",
                      obscureText: true),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: GestureDetector(
                      onTap: signUp,
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
                                'Sign Up',
                                style: TextStyle(
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
                      const Text('Already a member ?',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          ' Login now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
