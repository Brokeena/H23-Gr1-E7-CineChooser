import 'package:tmdb_api/tmdb_api.dart';
import 'movie.dart';

const String language = 'en-';
String country = 'CA';

final tmdb = TMDB( //TMDB instance
  ApiKeys('e99858b3004ef91a1e786cc7f99fde94', 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOTk4NThiMzAwNGVmOTFhMWU3ODZjYzdmOTlmZGU5NCIsInN1YiI6IjYzZWE5OTRmOGU4NzAyMDBkYzdiN2FlMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qOpj0nwkYQhC-8nubR4b-gT2qyJLPA65kCvWVl69ZkE'),
  logConfig: const ConfigLogger(
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
/// ********************************



  Future<List<String>> getTrendingMoviesImages() async{
  var searchTrending = await tmdb.v3.trending.getTrending(mediaType: MediaType.movie,timeWindow: TimeWindow.day);
  List<dynamic> results = searchTrending['results'];
  List<String> trendingMoviesImages = [];
  for(int i = 0; i < results.length; i++){
    String poster_path = 'https://image.tmdb.org/t/p/original'+results.elementAt(i)['poster_path'];
    trendingMoviesImages.add(poster_path);
  }
  return trendingMoviesImages;
}

  Future<List<Movie>> getTrendingMovies() async{
  List<Movie> trendingMovies = [];
  var searchTrending = await tmdb.v3.trending.getTrending(mediaType: MediaType.movie,timeWindow: TimeWindow.day);
  List<dynamic> results = searchTrending['results'];
  List<int> trendingMoviesId = [];
  for(int i = 0; i < results.length; i++){
    trendingMoviesId.add(results.elementAt(i)['id']);
  }
  for(int i = 0; i < trendingMoviesId.length; i++){
    trendingMovies.add(await Movie.create(trendingMoviesId.elementAt(i)));
  }

  return trendingMovies;

}



