import 'package:equatable/equatable.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/domain/entities/season.dart';

import '../../domain/entities/genre.dart';
import '../../domain/entities/tv_detail.dart';
import 'genre_model.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
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
  final List<GenreModel> genres;
  final List<SeasonModel> seasons;
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

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        backdropPath: json["backdrop_path"],
        episodeRunTime: json["episode_run_time"] != null
            ? List<int>.from(json["episode_run_time"].map((x) => x))
            : null,
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        name: json["name"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        type: json["type"],
        voteAverage: json["vote_average"]?.toDouble(),
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "episode_run_time": episodeRunTime != null
            ? List<dynamic>.from(episodeRunTime!.map((x) => x))
            : [],
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "name": name,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "type": type,
        "vote_average": voteAverage,
      };

  TvDetail toEntity() {
    return TvDetail(
      backdropPath: backdropPath,
      posterPath: posterPath,
      popularity: popularity,
      overview: overview,
      originalName: originalName,
      originalLanguage: originalLanguage,
      id: id,
      name: name,
      episodeRunTime: episodeRunTime,
      genres: List<Genre>.from(genres.map(
        (e) => Genre(id: e.id, name: e.name),
      )),
      homepage: homepage,
      type: type,
      voteAverage: voteAverage,
      seasons: List<Season>.from(
        seasons
            .map((e) => Season(
                  episodeCount: e.episodeCount,
                  id: e.id,
                  name: e.name,
                  overview: e.overview,
                  posterPath: e.posterPath,
                  seasonNumber: e.seasonNumber,
                ))
            .where(
              (element) => element.posterPath != null,
            ),
      ),
    );
  }

  @override
  // TODO: implement props
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
        seasons,
      ];
}
