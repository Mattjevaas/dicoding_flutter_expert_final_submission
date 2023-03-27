import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';

import 'tv_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTvs;

  late TvTopRatedBloc tvTopRatedBloc;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTv();
    tvTopRatedBloc = TvTopRatedBloc(
      getTopRatedTv: mockGetTopRatedTvs,
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

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'Should emit [Loading,HasData] when get fetch is success',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTvTopRatedMovie()),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'Should emit [Loading, Error] when get fetch is failed',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('fail')));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTvTopRatedMovie()),
    expect: () => [
      TvTopRatedLoading(),
      const TvTopRatedError('fail'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );
}
