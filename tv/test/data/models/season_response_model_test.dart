import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/season_detail_model.dart';

import '../../json_reader.dart';

void main() {
  const tSeasonDetailModel = SeasonDetailModel(
    seasonNumber: 1,
    posterPath: "/zwaj4egrhnXOBIit1tyb4Sbt3KP.jpg",
    overview:
        "Trouble is brewing in the Seven Kingdoms of Westeros. For the driven inhabitants of this visionary world, control of Westeros' Iron Throne holds the lure of great power. But in a land where the seasons can last a lifetime, winter is coming...and beyond the Great Wall that protects them, an ancient evil has returned. In Season One, the story centers on three primary areas: the Stark and the Lannister families, whose designs on controlling the throne threaten a tenuous peace; the dragon princess Daenerys, heir to the former dynasty, who waits just over the Narrow Sea with her malevolent brother Viserys; and the Great Wall--a massive barrier of ice where a forgotten danger is stirring.",
    id: "5256c89f19c2956ff6046d47",
    name: "Season 1",
    episodes: [
      EpisodeModel(
        name: "Winter Is Coming",
        id: 63056,
        episodeNumber: 1,
        stillPath: "/xIfvIM7YgkADTrqp23rm3CLaOVQ.jpg",
      ),
    ],
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/season_detail.json'));
      // act
      final result = SeasonDetailModel.fromJson(jsonMap);
      // assert
      expect(result, tSeasonDetailModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeasonDetailModel.toJson();
      // assert
      final expectedJsonMap = {
        "_id": "5256c89f19c2956ff6046d47",
        "episodes": [
          {
            "name": "Winter Is Coming",
            "id": 63056,
            "episode_number": 1,
            "still_path": "/xIfvIM7YgkADTrqp23rm3CLaOVQ.jpg",
          }
        ],
        "name": "Season 1",
        "overview":
            "Trouble is brewing in the Seven Kingdoms of Westeros. For the driven inhabitants of this visionary world, control of Westeros' Iron Throne holds the lure of great power. But in a land where the seasons can last a lifetime, winter is coming...and beyond the Great Wall that protects them, an ancient evil has returned. In Season One, the story centers on three primary areas: the Stark and the Lannister families, whose designs on controlling the throne threaten a tenuous peace; the dragon princess Daenerys, heir to the former dynasty, who waits just over the Narrow Sea with her malevolent brother Viserys; and the Great Wall--a massive barrier of ice where a forgotten danger is stirring.",
        "poster_path": "/zwaj4egrhnXOBIit1tyb4Sbt3KP.jpg",
        "season_number": 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}
