import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:movie/domain/entities/genre.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: "name");

  final tGenre = Genre(id: 1, name: "name");

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tGenreModel.toJson();
      // assert
      final expectedJsonMap = {"id": 1, "name": "name"};
      expect(result, expectedJsonMap);
    });
  });

  group('toEntity', () {
    test('should return a valid entity model', () async {
      // arrange

      // act
      final result = tGenreModel.toEntity();
      // assert
      expect(result, tGenre);
    });
  });
}
