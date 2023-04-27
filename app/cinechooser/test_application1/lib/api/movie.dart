import 'api.dart';

 class  Movie{
  late String nom;
  late int dateDeSortie;
  late String poster;
  late String overview;
  late List<String> directors;
  late List<String> actors;
  late List<String> providers;
  late double score;
  int id;
  late int runtime;
  List<Genre> genres = [];
  late bool inCinema = false;


  static Future<List<Movie>> createList (List<int> idList) async{
    List<Movie> movies = [];
    for(int i in idList){
      var movie = Movie._create(i);
      await movie._complexAsyncInit();
      movies.add(movie);
    }

    return movies;
  }

  Movie._create(this.id);

  static Future<Movie> create(int id) async{
    var movie = Movie._create(id);
    await movie._complexAsyncInit();
    return movie;
  }

  _complexAsyncInit() async{
    await setBasicsDetails(id);
    await setDirector(id);
    await setActors(id);
    await setWatchProviders(id);
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

  Future<void> setBasicsDetails(int id) async {
    Map movieRaw = await tmdb.v3.movies.getDetails(id);
    nom = movieRaw['title'];
    dateDeSortie = formatDate(movieRaw['release_date']);
    runtime = movieRaw['runtime'];
    score = movieRaw['vote_average'];
    overview = movieRaw['overview'];
    poster = "https://image.tmdb.org/t/p/original"  + movieRaw['poster_path'];

    List<dynamic> genresList = movieRaw['genres'];
    List<int> genresId = [];
    for(int i = 0; i < genresList.length; i++){
      genresId.add(genresList.elementAt(i)['id']);
    }
    await attribuerGenre(genresId);

  }

  Future<void> setDirector(int id) async {
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

  Future<void> setActors(int id) async {
    Map creditsDetails = await tmdb.v3.movies.getCredits(id);
    List cast = creditsDetails['cast'];
    List<String> actorsFound = ["Unknown"];
    if(cast.isNotEmpty){
      int x = 3;
      if(cast.length < 3){
        x = cast.length;
      }
      for(int i = 0; i < x; i++){
        if(actorsFound.elementAt(0) == "Unknown"){
          actorsFound.clear();
        }
        actorsFound.add(cast.elementAt(i)['name']);
      }
    }


    actors = actorsFound;
  }

  Future<void> setWatchProviders(int id) async {
    Map searchWatchProviders = await tmdb.v3.movies.getWatchProviders(id);
    List<dynamic> providersFound = [];
    if(searchWatchProviders['results'][country] == Null || searchWatchProviders['results'][country] == null){
      providers = ["Unavailable"];
    } else {
      if(searchWatchProviders['results'][country]['flatrate'] == Null || searchWatchProviders['results'][country]['flatrate'] == null){
        providersFound = [];
      } else {
        providersFound = searchWatchProviders['results'][country]['flatrate'];
      }
    }



    if(providersFound.isNotEmpty){
      List<String> providersNames = [];
      for( var value in providersFound){
        providersNames.add(value['provider_name']);
      }
      providers = providersNames;
    } else {
      List<String> none = ["In theatres now"];
      providers = none;
    }


  }

  Future<void> attribuerGenre(List<int> genresId) async{
    for(var value in Genre.values ){
      for(var id in genresId){
        if(value.id == id){
          genres.add(value);
        }
      }
    }

  }

  @override
  String toString() => 'Film : \n nom: $nom'
      ' \n dateDeSortie: $dateDeSortie'
      ' \n director: $directors'
      ' \n actors: $actors'
      ' \n runtime: $runtime'
      ' \n synopsis: $overview'
      ' \n score/10: $score'
      ' \n genres: $genres'
      ' \n watch on: $providers'
      ' \n poster: $poster'
      ' \n id TMDB: $id ';


}

enum Genre {
  Action(id: 28, name: 'Action'),
  Adventure(id: 12, name: 'Adventure'),
  Animation(id: 16, name:'Animation'),
  Comedy(id: 35, name:'Comedy'),
  Crime(id: 80, name: 'Crime'),
  Documentary(id: 99, name: 'Documentary'),
  Drama(id: 18, name: 'Drama'),
  Family(id: 10751, name: 'Family'),
  Fantasy(id: 14, name: 'Fantasy'),
  History(id: 36, name: 'History'),
  Horror(id: 27, name: 'Horror'),
  Music(id: 10402, name: 'Music'),
  Mystery(id: 9648, name: 'Mystery'),
  Romance(id: 10749, name: 'Romance'),
  ScienceFiction(id: 878, name: 'Science fiction'),
  TVMovie(id: 10770, name: 'Tv movie'),
  Thriller(id: 53, name: 'Thriller'),
  War(id: 10752, name:'War'),
  Western(id: 37, name: 'Western');


  const Genre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;


}













