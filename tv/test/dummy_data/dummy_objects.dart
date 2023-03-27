import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

const testTvDetail = TvDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 1,
  name: 'name',
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  episodeRunTime: [60],
  homepage: 'homePage',
  popularity: 1.0,
  type: "type",
  seasons: [
    Season(
      episodeCount: 0,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    ),
  ],
);

final testTv = Tv(
  backdropPath: 'backdropPath',
  genreIds: const [1, 2, 3],
  id: 1,
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
  originalName: 'originalName',
  originalLanguage: 'originalLanguage',
  name: 'name',
  originCountry: const ['originCountry'],
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvList = [testTv];

const testTvtable = TvTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  redirect: "tv",
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'redirect': 'tv',
};
