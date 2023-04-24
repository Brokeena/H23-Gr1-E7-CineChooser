import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:cinechooser/widget/button_carre.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/widget/textField.dart';
import 'package:cinechooser/pages/login_page.dart';
import 'package:cinechooser/utils/app_styles.dart';

import 'choix.dart';

class SetupUtilisateur extends StatefulWidget {

  const SetupUtilisateur({Key? key}) : super(key: key);

  @override
  State<SetupUtilisateur> createState() => _SetupUtilisateurState();
}

class _SetupUtilisateurState extends State<SetupUtilisateur> {
  void _navigateToPreviousScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  //controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  dynamic dropdownvalues = "item1";
  List listItemPays = [
    "item1",
    "item2",
    "item3",
    "item4",
    "item5",
    "item6",
    "item7",
    "item8",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Personnaliser votre compte', style: Styles.entete),
        leading: IconButton(
          onPressed: () {
            _navigateToPreviousScreen(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            /* gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Styles.red2,
          ],
        )*/
            color: Styles.bgColor),
        child: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  MyTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ))),
                    child: DropdownButton(
                        value: dropdownvalues,
                        dropdownColor: Colors.grey.shade600,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        elevation: 10,
                        items: [
                          "item1",
                          "item2",
                          "item3",
                          "item4",
                          "item5",
                          "item6",
                          "item7",
                          "item8",
                        ]
                            .map((dynamic value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ))
                            .toList(),
                        onChanged: (newItem) {
                          setState(() {
                            dropdownvalues = newItem!;
                          });
                        }),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Button(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Choix()),
                        );
                      },
                      icone: const Icon(Icons.arrow_forward_ios, color: Styles.red1),
                      color: Colors.white,
                      taille: 64,
                      borderRadius: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
