import 'package:equatable/equatable.dart';

import 'episode.dart';

class SeasonDetail extends Equatable {
  SeasonDetail({
    required this.id,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props => [
        id,
        episodes,
        name,
        overview,
        seasonNumber,
      ];
}
