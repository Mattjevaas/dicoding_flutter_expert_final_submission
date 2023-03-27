import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String redirect;

  const MovieTable(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview,
      required this.redirect});

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        redirect: "movie",
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        redirect: map['redirect'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'redirect': "movie",
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
        redirect: redirect,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
