import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Styles.bgColor,
        elevation: 0,
        title: const Text('Your profile', style: Styles.preTitre),
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: width / 9),
          child: Column(
            children: [
              Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  direction: Axis.horizontal,
                  children: likedMovies
                      .map((e) => Chip(label: Text(e as String)))
                      .toList())
            ],
          ),
        ),
      ),
    );
  }
}
