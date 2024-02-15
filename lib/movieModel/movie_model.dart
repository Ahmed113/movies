class MovieModel{
  String? title;
  String? posterPath;
  String? overview;
  String? backdropPath;
  double? voteAverage;
  String? releaseDate;
  int? id;
  List<dynamic>? genre;

  MovieModel({this.title, this.posterPath, this.overview, this.backdropPath,
    this.voteAverage, this.releaseDate, this.id, this.genre});

  MovieModel.fromjson(Map<String, dynamic> json){
    title = json['title'];
    posterPath = json['poster_path'];
    overview = json['overview'];
    backdropPath = json['backdrop_path'];
    voteAverage = json['vote_average'];
    releaseDate = json['release_date'];
    id = json['id'];
    genre = json['genre_ids'];
  }
}