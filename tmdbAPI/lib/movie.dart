import 'dart:collection';

import 'package:tmdb_api/tmdb_api.dart';

String country = 'CA';

final tmdb = TMDB( //TMDB instance
  ApiKeys('e99858b3004ef91a1e786cc7f99fde94', 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOTk4NThiMzAwNGVmOTFhMWU3ODZjYzdmOTlmZGU5NCIsInN1YiI6IjYzZWE5OTRmOGU4NzAyMDBkYzdiN2FlMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qOpj0nwkYQhC-8nubR4b-gT2qyJLPA65kCvWVl69ZkE'),
  logConfig: ConfigLogger(
    showLogs: true,//must be true than only all other logs will be shown
    showErrorLogs: true,
  ), defaultLanguage:'en-' + country,
);


Future<void> main(List<String> arguments) async {

  //Method
  List<String> findJobIndexInList(List<dynamic> searchIn, String searchTerm){
    List<String> jobs = ["unknown"];
    for(int i = 0; i < searchIn.length ; i++){
      if(searchIn.elementAt(i)['job'] == searchTerm){
        if(jobs.elementAt(0) == "unknown"){
          jobs.clear();
        }
        jobs.add(searchIn.elementAt(i)['name']);
      }
    }
    return jobs;
  }


  List<String> findFirstActors(List<dynamic> searchIn, int nbOfActor){
    List<String> actors = ["unknown"];
    for(int i = 0; i < nbOfActor; i++){
      if(actors.elementAt(0) == "unknown"){
        actors.clear();
      }
      actors.add(searchIn.elementAt(i)['name']);
    }
    return actors;
  }


  int formatDate(String date){
    String dateF = "";
    for(int i = 0; i < 4; i++){
      dateF += date[i];
    }
    return int.parse(dateF);
  }



  
  //Research
  Map search = await tmdb.v3.search.queryMovies("Zombieland");
  List<dynamic> result = search['results'];
  Map movie = await tmdb.v3.movies.getDetails(result.elementAt(0)['id']);
  
  //Find directors
  Map creditsDetails = await tmdb.v3.movies.getCredits(result.elementAt(0)['id']);
  List crew = creditsDetails['crew'];

  //Find actors
  List cast = creditsDetails['cast'];
  List<String> actors = findFirstActors(cast, 3);

  //Genres
  List<dynamic> genresList = movie['genres'];
  List<int>? genresId = [];
  for(int i = 0; i < genresList.length; i++){
    genresId.add(genresList.elementAt(i)['id']);
  }

  //Providers
  Map searchWatchProviders = await tmdb.v3.movies.getWatchProviders(result.elementAt(0)['id']);
  List providers = searchWatchProviders['results'][country]['flatrate'];
  List<String> providersName = [];
  for( var value in providers){
    providersName.add(value['provider_name']);
  }




  Movie movieSearched = new Movie(movie['title'], formatDate(movie['release_date']), movie['overview'], findJobIndexInList(crew, "Director"), actors, movie['runtime'], movie['vote_average'], providersName, "https://image.tmdb.org/t/p/original"  + movie['poster_path'], movie['id'],genresId);


  
  print(providersName);
  print("-----------------------");
  print(movieSearched.toString());



}


class Movie{
  String nom;
  int dateDeSortie;
  String poster;
  String overview;
  List<String> director;
  List<String> actors;
  List<String> providers;
  double score;
  int id;
  int runtime;
  List<int> genresId = [];
  List<Genre> genres = [];


  Movie(this.nom,this.dateDeSortie, this.overview, this.director, this.actors, this.runtime, this.score, this.providers, this.poster, this.id, this.genresId){
    attribuerGenre();
  }
  

  void attribuerGenre(){
    for(var value in Genre.values ){
      for(int id in genresId){
        if(value.id == id){
          genres.add(value);
        }
      }
    }
  }


  @override
  String toString() => 'Film trouvée: \n nom: $nom, \n dateDeSortie: $dateDeSortie, \n director: $director, \n actors: $actors, \n runtime: $runtime, \n synopsis: $overview, \n score/10: $score, \n genres: $genres, \n watch on: $providers, \n poster: $poster \n id TMDB: $id ';


}


enum Genre {
  Action(id: 28, name: 'action'),
  Adventure(id: 12, name: 'adventure'),
  Animation(id: 16, name:'animation'),
  Comedy(id: 35, name:'comedy'),
  Crime(id: 80, name: 'crime'),
  Documentary(id: 99, name: 'documentary'),
  Drama(id: 18, name: 'drama'),
  Family(id: 10751, name: 'family'),
  Fantasy(id: 14, name: 'fantasy'),
  History(id: 36, name: 'history'),
  Horror(id: 27, name: 'horror'),
  Music(id: 10402, name: 'music'),
  Mystery(id: 9648, name: 'mystery'),
  Romance(id: 10749, name: 'romance'),
  ScienceFiction(id: 878, name: 'science fiction'),
  TVMovie(id: 10770, name: 'tv movie'),
  Thriller(id: 53, name: 'thriller'),
  War(id: 10752, name:'war'),
  Western(id: 37, name: 'western');


 


  const Genre({
   required this.id,
   required this.name,
});

  final int id;
  final String name;
}


