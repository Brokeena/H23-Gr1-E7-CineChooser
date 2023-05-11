import 'package:flutter/material.dart';

class LikedMovies extends StatefulWidget {
  const LikedMovies({Key? key}) : super(key: key);

  @override
  State<LikedMovies> createState() => _LikedMoviesState();
}

class _LikedMoviesState extends State<LikedMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
          child: Text('Jaime bien', style: TextStyle(color: Colors.white),)),
    );
  }
}
