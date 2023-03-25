import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.posterPath,
    required this.popularity,
    required this.id,
    this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  final String? posterPath;
  final int id;
  final String overview;
  final String name;
  double? popularity;
  String? backdropPath;
  double? voteAverage;
  List<String>? originCountry;
  List<int>? genreIds;
  String? originalLanguage;
  int? voteCount;
  String? originalName;

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        originCountry,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName,
      ];
}
