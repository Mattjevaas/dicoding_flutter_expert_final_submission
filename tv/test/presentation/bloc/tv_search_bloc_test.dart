import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/bloc/tv_search/tv_search_bloc.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late MockSearchTv mockSearchTvs;

  late TvSearchBloc tvSearchBloc;

  setUp(() {
    mockSearchTvs = MockSearchTv();
    tvSearchBloc = TvSearchBloc(searchTvs: mockSearchTvs);
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
  const tQuery = 'name';

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading,HasData] when get fetch is success',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const SearchTvProgram(tQuery)),
    expect: () => [
      TvSearchLoading(),
      TvSearchHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Error] when get fetch is failed',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('fail')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const SearchTvProgram(tQuery)),
    expect: () => [
      TvSearchLoading(),
      const TvSearchError('fail'),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );
}
