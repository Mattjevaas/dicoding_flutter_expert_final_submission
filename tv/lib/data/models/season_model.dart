import 'package:equatable/equatable.dart';

import '../../domain/entities/season.dart';

class SeasonModel extends Equatable {
  const SeasonModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.episodeCount,
    required this.seasonNumber,
  });

  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  Season toEntity() {
    return Season(
      name: name,
      id: id,
      overview: overview,
      posterPath: posterPath,
      episodeCount: episodeCount,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
