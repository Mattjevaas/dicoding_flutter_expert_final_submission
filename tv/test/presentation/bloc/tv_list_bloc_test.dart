import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/tv_list/tv_list_bloc.dart';

import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv, GetPopularTv, GetTopRatedTv])
void main() {
  late TvListBloc tvListBloc;

  late MockGetNowPlayingTv mockGetNowPlayingTvs;
  late MockGetPopularTv mockGetPopularTvs;
  late MockGetTopRatedTv mockGetTopRatedTvs;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTv();
    mockGetPopularTvs = MockGetPopularTv();
    mockGetTopRatedTvs = MockGetTopRatedTv();
    tvListBloc = TvListBloc(
      getNowPlayingTvs: mockGetNowPlayingTvs,
      getPopularTvs: mockGetPopularTvs,
      getTopRatedTvs: mockGetTopRatedTvs,
    );
  });

  final tTv = Tv(
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
  final tTvList = <Tv>[tTv];

  blocTest<TvListBloc, TvListState>(
    'Should emit [Loading,HasData] when get fetch is success',
    build: () {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));

      return tvListBloc;
    },
    act: (bloc) => bloc.add(FetchTvList()),
    expect: () => [
      TvListLoading(),
      TvListHasData(
        nowPlaying: tTvList,
        popular: tTvList,
        topRated: tTvList,
      ),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvs.execute());
      verify(mockGetTopRatedTvs.execute());
      verify(mockGetPopularTvs.execute());
    },
  );

  blocTest<TvListBloc, TvListState>(
    'Should emit [Loading,Error] when get fetch is failed',
    build: () {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('fail')));
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('fail')));
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('fail')));

      return tvListBloc;
    },
    act: (bloc) => bloc.add(FetchTvList()),
    expect: () => [TvListLoading(), const TvListError('fail')],
    verify: (bloc) {
      verify(mockGetNowPlayingTvs.execute());
      verify(mockGetTopRatedTvs.execute());
      verify(mockGetPopularTvs.execute());
    },
  );
}
