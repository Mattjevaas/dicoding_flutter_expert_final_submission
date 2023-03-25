import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/season_detail_model.dart';
import 'package:tv/domain/entities/episode.dart';
import 'package:tv/domain/entities/season_detail.dart';

void main() {
  final tSeasonDetailModel = SeasonDetailModel(
    id: "1234",
    episodes: [
      EpisodeModel(episodeNumber: 1, id: 1, name: "name", stillPath: "path")
    ],
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
  );

  final tSeasonDetail = SeasonDetail(
    id: "1234",
    episodes: [
      Episode(episodeNumber: 1, id: 1, name: "name", stillPath: "path")
    ],
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
  );

  test('should be a subclass of Season Entity', () async {
    final result = tSeasonDetailModel.toEntity();
    expect(result, tSeasonDetail);
  });
}
