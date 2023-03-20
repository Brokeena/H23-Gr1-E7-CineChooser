import 'package:flutter/material.dart';
import 'package:test_application1/pages/login_page.dart';
import 'package:test_application1/api/movie.dart';
import 'package:test_application1/api/api.dart';
String poster = '';

void main() async
{
  runApp(const MyApp());
  Movie movie = await Movie.create(18491);
  poster = movie.poster;
}



class MyApp extends StatelessWidget
{

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

