import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';

class Reglages extends StatefulWidget {
  const Reglages({Key? key}) : super(key: key);

  @override
  State<Reglages> createState() => _ReglagesState();
}

class _ReglagesState extends State<Reglages> {
  void _navigateToPreviousScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const PagePrincipale()));
  }

  dynamic dropdownvalues = "pays";
  List listItemPays = [
    "pays",
    "CA",
    "US",
    "RU",
    "JA",
    "AU",
    "ES",
    "BE",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Réglages de votre compte', style: Styles.entete),
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
        decoration: const BoxDecoration(color: Styles.bgColor),
        child: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
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
                        dropdownColor: Styles.bgColor,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        elevation: 10,
                        items: [
                          "pays",
                          "CA",
                          "US",
                          "RU",
                          "JA",
                          "AU",
                          "ES",
                          "BE",
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

                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
