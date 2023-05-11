import 'package:cinechooser/pages/auth_page.dart';
import 'package:cinechooser/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/api/movie.dart';
import 'package:cinechooser/api/api.dart';
import 'package:firebase_core/firebase_core.dart';

String poster = '';
List<Movie> displayedMovies = [];
List<Movie> testMovies = [];
List<Genre> genres = [Genre.Western, Genre.ScienceFiction, Genre.Animation];


List<int> idGenre = [
  28,
  12,
  16,
  35,
  80,
  99,
  18,
  10751,
  14,
  36,
  27,
  10402,
  9648,
  10749,
  878,
  53,
  10752,
  37
];
List<String> nomGenre = [
  'Action',
  'Adventure',
  'Animation',
  'Comedy',
  'Crime',
  'Documentary',
  'Drama',
  'Family',
  'Fantasy',
  'History',
  'Horror',
  'Music',
  'Mystery',
  'Romance',
  'Science fiction',
  'Thriller',
  'War',
  'Western'
];
List<bool> selectionne = [
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true
];
List<double> borders = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
List<Color> colors = [
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
  Colors.transparent,
];

void main() async {
  Movie movie = await Movie.create(18491);
  if(!firstTime){
    openApp();
  }
  poster = movie.poster;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAf7-d8wh14Q0-Yjju-beR2mVHpzeOP2ns",
          appId: 'cinechooser',
          messagingSenderId: '1026537403163',
          projectId: 'cinechooser-eva01'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
