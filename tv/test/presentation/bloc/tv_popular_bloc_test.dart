import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';

import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTvs;

  late TvPopularBloc tvPopularBloc;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTv();
    tvPopularBloc = TvPopularBloc(getPopularTv: mockGetPopularTvs);
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    name: 'name',
    originCountry: ['originCountry'],
  );

  final tTvList = <Tv>[tTv];

  blocTest<TvPopularBloc, TvPopularState>(
    'Should emit [Loading,HasData] when get fetch is success',
    build: () {
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(FetchTvPopularMovie()),
    expect: () => [
      TvPopularLoading(),
      TvPopularHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );

  blocTest<TvPopularBloc, TvPopularState>(
    'Should emit [Loading, Error] when get fetch is failed',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('fail')));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(FetchTvPopularMovie()),
    expect: () => [
      TvPopularLoading(),
      TvPopularError('fail'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );
}
