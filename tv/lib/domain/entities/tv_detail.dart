import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/season.dart';

import 'genre.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.backdropPath,
    required this.episodeRunTime,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.type,
    required this.voteAverage,
    required this.seasons,
  });

  final String? backdropPath;
  final List<int>? episodeRunTime;
  final List<Genre> genres;
  final List<Season> seasons;
  final String homepage;
  final int id;
  final String name;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String type;
  final double voteAverage;

  @override
  List<Object?> get props => [
        backdropPath,
        episodeRunTime,
        genres,
        homepage,
        id,
        name,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        type,
        voteAverage,
        seasons,
      ];
}
