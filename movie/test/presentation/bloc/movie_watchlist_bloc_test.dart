import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/common/failure.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  late MovieWatchlistBloc movieWatchlistBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    movieWatchlistBloc = MovieWatchlistBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading,HasData] when get fetch is success',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistHasData([testWatchlistMovie]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading, Error] when get fetch is failed',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Left(DatabaseFailure('fail')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      MovieWatchlistLoading(),
      const MovieWatchlistError('fail'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
