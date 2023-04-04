import 'api.dart';

 class  Movie{
  late String nom;
  late int dateDeSortie;
  late String poster;
  late String overview;
  late List<String> directors;
  late List<String> actors;
  late List<String> providers = ["none"];
  late double score;
  int id;
  late int runtime;
  List<Genre> genres = [];


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
    //await setWatchProviders(id);
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
    List<String> actorsFound = ["unknown"];
    for(int i = 0; i < 3; i++){
      if(actorsFound.elementAt(0) == "unknown"){
        actorsFound.clear();
      }
      actorsFound.add(cast.elementAt(i)['name']);
    }

    actors = actorsFound;
  }

  Future<void> setWatchProviders(int id) async {
    Map searchWatchProviders = await tmdb.v3.movies.getWatchProviders(id);
    List providersFound = searchWatchProviders['results'][country]['flatrate'];
    if(providersFound != Null){
      List<String> providersNames = [];
      for( var value in providersFound){
        providersNames.add(value['provider_name']);
      }
      providers = providersNames;
    } else {
      List<String> none = ["None"];
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













