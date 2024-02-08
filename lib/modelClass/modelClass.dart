

class Movie{

  String title;
  String poster;
  Movie({required this.title,required this.poster});

  factory Movie.fromJson(Map<String,dynamic> json)=>Movie(
      title: json["title"],
      poster: json["poster_path"]);
}