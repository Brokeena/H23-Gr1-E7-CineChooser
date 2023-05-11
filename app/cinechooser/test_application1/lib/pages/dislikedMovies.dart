import 'package:flutter/material.dart';

class DislikedMovies extends StatefulWidget {
  const DislikedMovies({Key? key}) : super(key: key);

  @override
  State<DislikedMovies> createState() => _DislikedMoviesState();
}

class _DislikedMoviesState extends State<DislikedMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
          child: Text('Jaime pas', style: TextStyle(color: Colors.white),)),
    );
  }
}
