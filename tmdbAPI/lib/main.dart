import 'dart:collection';
import 'package:tmdb_api/tmdb_api.dart';
import 'movie.dart';
import 'api.dart';





Future<void> main(List<String> arguments) async
{
  Movie movie = await Movie.create(545611);
  // https://stackoverflow.com/questions/38933801/calling-an-async-method-from-a-constructor-in-dart
  // https://github.com/dart-lang/sdk/issues/23115

  print(movie);


}








