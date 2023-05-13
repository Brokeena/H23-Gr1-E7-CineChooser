

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
/// *********************************

  Future<List<Movie>> getMoviesWithId(List<dynamic> ListId) async{
    List<Movie> listMovies = [];
    for(var id in ListId){
      listMovies.add(await Movie.create(id));
    }
    return listMovies;
  }

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
  var searchTrending = await tmdb.v3.trending.getTrending(mediaType: MediaType.movie,timeWindow: TimeWindow.week);
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

  Future<List<Movie>> getTrendingMoviesByGenres(List<Genre> genres) async{
    List<Movie> trendingMovies = [];
    var searchTrending = await tmdb.v3.trending.getTrending(mediaType: MediaType.movie,timeWindow: TimeWindow.week);
    List<dynamic> results = searchTrending['results'];
    List<int> trendingMoviesId = [];
    for(int i = 0; i < results.length; i++){
      for(int g = 0; g < genres.length; g++){
        for(int j = 0; j < results.elementAt(i)['genre_ids'].length; j++){
          if(genres.elementAt(g).id == results.elementAt(i)['genre_ids'].elementAt(j)){
            trendingMoviesId.add(results.elementAt(i)['id']);
            g = genres.length;
            j = results.elementAt(i)['genre_ids'].length;
          }
        }
      }
      trendingMoviesId.add(results.elementAt(i)['id']);
    }

    for(int t = 0; t < trendingMoviesId.length; t++){
      trendingMovies.add(await Movie.create(trendingMoviesId.elementAt(t)));
    }

    return trendingMovies;
  }

  Future<List<Movie>> getTopRatedMoviesByGenres(List<dynamic> genres, int range) async{
  List<Movie> listMovies = [];
  for(int r = 1; r <= range; r++){
    var searchTopRated = await tmdb.v3.movies.getTopRated(language: language+country, page: r);
    List<dynamic> results = searchTopRated['results'];
    List<int> topRatedMoviesId = [];
    for(int i = 0; i < results.length; i++){
      for(int k = 0; k < genres.length; k++){
        for(int j = 0; j < results.elementAt(i)['genre_ids'].length; j++){
          if(genres.elementAt(k) == results.elementAt(i)['genre_ids'].elementAt(j)){
            topRatedMoviesId.add(results.elementAt(i)['id']);
            k = genres.length;
            j = results.elementAt(i)['genre_ids'].length;
          }
        }
      }
    }

    for(int x = 0; x < topRatedMoviesId.length; x++){
      listMovies.add(await Movie.create(topRatedMoviesId.elementAt(x)));
    }
  }
  return listMovies;
}

  Future<List<Movie>> getRecommendedMovies(int id) async{

  List<Movie> listMovies = [];
  var searchSimilar = await tmdb.v3.movies.getRecommended(id);
  List<dynamic> results = searchSimilar['results'];
  List<int> similarMoviesId = [];
  for(int n = 0; n < results.length; n++){
    similarMoviesId.add(results.elementAt(n)['id']);
  }
  for(int x = 0; x < similarMoviesId.length; x++){
    listMovies.add(await Movie.create(similarMoviesId.elementAt(x)));
  }
  return listMovies;
}




