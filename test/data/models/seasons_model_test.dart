import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonsModel = SeasonModel(
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
    id: 1,
    episodeCount: 1,
  );

  final tSeasons = Season(
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
    id: 1,
    episodeCount: 1,
  );

  group('toEntity', () {
    test('should be a subclass of Season Entity', () async {
      final result = tSeasonsModel.toEntity();
      expect(result, tSeasons);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tSeasonsModel.toJson();
      // assert
      final expectedJsonMap = {
        "name": "name",
        "overview": "overview",
        "poster_path": "posterPath",
        "season_number": 1,
        "id": 1,
        "episode_count": 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}
