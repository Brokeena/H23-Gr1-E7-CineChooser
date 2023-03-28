import 'package:flutter/material.dart';
import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:cinechooser/pages/login_page.dart';
import 'package:cinechooser/api/movie.dart';
import 'package:cinechooser/api/api.dart';
import 'package:firebase_core/firebase_core.dart';

String poster = '';

void main() async {
  var liste = getTrendingMovies();
  Movie movie = await Movie.create(18491);
  poster = movie.poster;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAf7-d8wh14Q0-Yjju-beR2mVHpzeOP2ns",
          appId: 'cinechooser',
          messagingSenderId: '1026537403163',
          projectId: 'cinechooser-eva01'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PagePrincipale(),
    );
  }
}
