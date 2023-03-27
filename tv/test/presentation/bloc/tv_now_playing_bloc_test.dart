import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';

import 'tv_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTvs;

  late TvNowPlayingBloc tvNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTv();
    tvNowPlayingBloc = TvNowPlayingBloc(getNowPlayingTv: mockGetNowPlayingTvs);
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

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    'Should emit [Loading,HasData] when get fetch is success',
    build: () {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchTvNowPlayingMovie()),
    expect: () => [
      TvNowPlayingLoading(),
      TvNowPlayingHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvs.execute());
    },
  );

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    'Should emit [Loading, Error] when get fetch is failed',
    build: () {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('fail')));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchTvNowPlayingMovie()),
    expect: () => [
      TvNowPlayingLoading(),
      const TvNowPlayingError('fail'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvs.execute());
    },
  );
}
