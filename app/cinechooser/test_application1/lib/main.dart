import 'package:cinechooser/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/api/movie.dart';
import 'package:cinechooser/api/api.dart';
import 'package:firebase_core/firebase_core.dart';

String poster = '';
List<Movie> displayedMovies = [];
List<Movie> testMovies = [];
List<Genre> genres = [Genre.Western, Genre.ScienceFiction, Genre.Animation];

List<String> imageGenre = [
  'https://cdn.vox-cdn.com/thumbor/fzd6PmGPMSwSDWaqS7ZH-V9Mo5Q=/165x0:2880x1189/1200x800/filters:focal(810x26:1270x486)/cdn.vox-cdn.com/uploads/chorus_image/image/70298838/Screen_Shot_2021_12_20_at_2.40.13_PM.0.png',
  'https://hips.hearstapps.com/hmg-prod/images/indiana-jones-movies-in-order-1981-raiders-1-1637254187.jpg?crop=1.00xw:0.994xh;0,0&resize=1200:*',
  'https://cloudfront-us-east-1.images.arcpublishing.com/infobae/VFDES4X7YZDYTNQA4ZN3TRZBBM.jpg',
  'https://www.metacritic.com/a/img/resize/1241553df285fc407f5ea6c65a6c6e2ae6baee23/hub/2022/08/10/65504ecb-d12b-493d-b1ca-09cfda86c884/screen-shot-2022-08-10-at-5-46-10-am.png?auto=webp&width=1092',
  'https://lapepinieregeneve.ch/wp-content/uploads/2021/09/11.09-11h-Le-Parrain-1-Durovray-banner.jpg',
  'https://occ-0-999-1001.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABaOXOzba1FpfVI8hIneZV_5TfieC8WJ0JN5Jbwm5cWBooxCtoG91ZlzDjNQyAPco-lEcLd3sSN-KKBqkzb0x631L1Af5wowHsJUt.jpg?r=ded',
  'https://m.media-amazon.com/images/M/MV5BYzA4ZWRhNjktMTA3ZS00NDNiLThmMDMtNzdlYzk0ZjY2ZGFmXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjn4Z95lsoMHxJ4LdwGhowx183wxjGJjcEmLBT0Di228ax6Q4D-PZzmo1X4dQESLSX6fI&usqp=CAU',
  'https://www.1jour1actu.com/wp-content/uploads/2021/12/VIDEO_Harry_Potter.jpeg',
  'https://i0.wp.com/didierlong.com/wp-content/uploads/2013/07/famous-girl-in-red-scene-from-the-academy-award-winning-film-schindlers-list.png',
  'https://ciclic.fr/sites/default/files/photo_1_jaws.jpg',
  'https://compote.slate.com/images/3412cd17-bfdc-4925-bdc9-f5b8e5e3c2ab.jpg',
  'https://www.lemagducine.fr/wp-content/uploads/2016/07/seven-david-fincher-film-critique.jpg',
  'https://wordpress.wbur.org/wp-content/uploads/2019/06/Titanic-1.jpg',
  'https://images.bauerhosting.com/legacy/empire-tmdb/films/157336/images/xu9zaAevzQ5nnrsXN6JcahLnG4i.jpg?format=jpg&quality=80&width=960&height=540&ratio=16-9&resize=aspectfill',
  'https://people.com/thmb/9fOQTvrvpmv5LlcwMoULKyg9hJo=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():focal(399x0:401x2)/memento-film-800-f052d4cb69b04fc08019adf53eee87ca.jpg',
  'https://fr.web.img5.acsta.net/newsv7/19/06/06/17/22/1389810.jpg',
  'https://www.rts.ch/2017/07/26/16/42/3200399.image?mw=1280',
];
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
  displayedMovies = await getTopRatedMoviesByGenres(genres, 2);
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
