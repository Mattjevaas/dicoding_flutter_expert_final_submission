import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:equatable/equatable.dart';

import 'episode_model.dart';

class SeasonDetailModel extends Equatable {
  SeasonDetailModel({
    required this.id,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      SeasonDetailModel(
        id: json["_id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        episodes: json["episodes"] != null
            ? List<EpisodeModel>.from(
                    json["episodes"].map((x) => EpisodeModel.fromJson(x)))
                .where((element) => element.stillPath != null)
                .toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  SeasonDetail toEntity() => SeasonDetail(
        id: id,
        episodes: List<Episode>.from(
          episodes.map(
            (e) => Episode(
                episodeNumber: e.episodeNumber,
                id: e.id,
                name: e.name,
                stillPath: e.stillPath!),
          ),
        ),
        name: name,
        overview: overview,
        posterPath: posterPath,
        seasonNumber: seasonNumber,
      );

  @override
  List<Object?> get props => [
        id,
        episodes,
        name,
        overview,
        seasonNumber,
      ];
}
