import 'package:tmdb_api/tmdb_api.dart';
import 'package:untitled/movie.dart';
import 'movie.dart';

final String language = 'en-';
final String country = 'CA';

final tmdb = TMDB( //TMDB instance
  ApiKeys('e99858b3004ef91a1e786cc7f99fde94', 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOTk4NThiMzAwNGVmOTFhMWU3ODZjYzdmOTlmZGU5NCIsInN1YiI6IjYzZWE5OTRmOGU4NzAyMDBkYzdiN2FlMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qOpj0nwkYQhC-8nubR4b-gT2qyJLPA65kCvWVl69ZkE'),
  logConfig: ConfigLogger(
    showLogs: true,//must be true than only all other logs will be shown
    showErrorLogs: true,
  ), defaultLanguage:language + country,
);

String language_country(){
  return language+country;
}










/// Récuperer listes de films
/// *********************************
/// *********************************
/// *********************************
/// *********************************



  Future<List<Movie>> getTrendingMovies() async{
  var searchTrending = await tmdb.v3.trending.getTrending(mediaType: MediaType.movie,timeWindow: TimeWindow.day);
  var results = searchTrending['results'];
  List<Movie>? trendingMovies = [];
  for(int i = 0; i < results.length; i++){
    int id = results.elementAt(i)['id'];
    Movie movie = await Movie.create(id);
    trendingMovies.add(movie);
  }
  return trendingMovies;
}

