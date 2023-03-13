import 'api.dart';

 class  Movie{
  String? nom;
  int? dateDeSortie;
  String? poster;
  String? overview;
  List<String>? directors;
  List<String>? actors;
  List<String>? providers;
  double? score;
  int id;
  int? runtime;
  List<int> genresId = [];
  List<Genre> genres = [];


  Movie(this.id) {
    setDetails(id);
    attribuerGenre();
    setDirector(id);
    setActors(id);
    setWatchProviders(id);
  }


  /// Méthode pour créer correctement un film
  /// *********************************
  /// *********************************
  /// *********************************
  /// *********************************

  int formatDate(String date){
    String dateF = "";
    for(int i = 0; i < 4; i++){
      dateF += date[i];
    }
    return int.parse(dateF);
  }

  void setDetails(int id) async {
    Map movieRaw = await tmdb.v3.movies.getDetails(id);
    nom = movieRaw['title'];
    dateDeSortie = formatDate(movieRaw['release_date']);
    runtime = movieRaw['runtime'];
    score = movieRaw['vote_average'];
    poster = "https://image.tmdb.org/t/p/original"  + movieRaw['poster_path'];
  }

  void setDirector(int id) async {
    Map creditsDetails = await tmdb.v3.movies.getCredits(id);
    List crew = creditsDetails['crew'];
    List<String> directorsFound = ["unknown"];
    for(int i = 0; i < crew.length ; i++){
      if(crew.elementAt(i)['job'] == "Director"){
        if(directorsFound.elementAt(0) == "unknown"){
          directorsFound.clear();
        }
        directorsFound.add(crew.elementAt(i)['name']);
      }
    }

    directors = directorsFound;

  }

  void setActors(int id) async {
    Map creditsDetails = await tmdb.v3.movies.getCredits(id);
    List cast = creditsDetails['cast'];
    List<String> actorsFound = ["unknown"];
    for(int i = 0; i < 3; i++){
      if(actorsFound.elementAt(0) == "unknown"){
        actorsFound.clear();
      }
      actorsFound.add(cast.elementAt(i)['name']);
    }

    actors = actorsFound;
  }

  void setWatchProviders(int id) async {
    Map searchWatchProviders = await tmdb.v3.movies.getWatchProviders(id);
    List providersFound = searchWatchProviders['results'][country]['flatrate'];
    List<String> providersNames = [];
    for( var value in providersFound){
      providersNames.add(value['provider_name']);
    }
    providers = providersNames;

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

  Future<bool> check() async{
    if(nom!=null){
      return true;
    } else{
      return false;
    }
  }


  @override
  String toString() => 'Film trouvée: \n nom: $nom, \n dateDeSortie: $dateDeSortie, \n director: $directors, \n actors: $actors, \n runtime: $runtime, \n synopsis: $overview, \n score/10: $score, \n genres: $genres, \n watch on: $providers, \n poster: $poster \n id TMDB: $id ';


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













