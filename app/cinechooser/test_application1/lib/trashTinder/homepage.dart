import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application1/trashTinder/CardProvider.dart';
import 'package:test_application1/trashTinder/moviecard.dart';




class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: buildCards(),
          ),
        ),
      );


    Widget buildCards() {
      final provider = Provider.of<CardProvider>(context);
      final urlImages = provider.urlImages;

      print(urlImages);
    return Stack(
        children: urlImages.map((urlImage) =>
            MovieCard(
              urlImage: urlImage,
              //isFront: urlImages.last == urlImage,
            ))
            .toList(),
      );
    }

  }

