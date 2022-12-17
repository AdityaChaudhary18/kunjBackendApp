class MovieModel {
  final String? poster;
  final String? title;
  final String? genre;
  final String? rating;

  MovieModel({this.title, this.poster, this.genre, this.rating});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      poster: json['poster'] ?? "",
      title: json['title'] ?? "",
      genre: json['genre'] ?? "",
      rating: json['rating'] ?? "",
    );
  }
}
