import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application1/pages/pagePrincipale.dart';
import 'package:test_application1/trashTinder/homepage.dart';
import 'package:test_application1/pages/login_page.dart';
import 'package:test_application1/api/movie.dart';
import 'package:test_application1/api/api.dart';

import '../trashTinder/CardProvider.dart';
String poster = '';

void main() async
{
  Movie movie = await Movie.create(18491);
  poster = movie.poster;
  runApp(const MyApp());

}



class MyApp extends StatelessWidget
{

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}



