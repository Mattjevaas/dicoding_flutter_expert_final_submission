import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/common/failure.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_watchlist/movie_detail_watchlist_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_watchlist/movie_detail_watchlist_event.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_watchlist/movie_detail_watchlist_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  late MovieDetailWatchlistBloc movieDetailWatchlistBloc;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();

    movieDetailWatchlistBloc = MovieDetailWatchlistBloc(
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
      getWatchListStatus: mockGetWatchListStatus,
    );
  });

  final tId = 1;

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'Should emit [AlreadyOnWatchlist] when get add is success',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('success'));
      return movieDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieAddWatchList(testMovieDetail)),
    expect: () => [
      UpdatingWatchlist(),
      AlreadyOnWatchlist(),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'Should emit [WatchlistError] when get add is failed',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('fail')));
      return movieDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieAddWatchList(testMovieDetail)),
    expect: () => [
      UpdatingWatchlist(),
      WatchlistError('fail'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'Should emit [NotOnWatchlist] when get remove is success',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('success'));
      return movieDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieRemoveWatchList(testMovieDetail)),
    expect: () => [
      UpdatingWatchlist(),
      NotOnWatchlist(),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'Should emit [WatchlistError] when get remove is failed',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('fail')));
      return movieDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieRemoveWatchList(testMovieDetail)),
    expect: () => [
      UpdatingWatchlist(),
      WatchlistError('fail'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'Should emit [AlreadyOnWatchList] when get status returning true',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return movieDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieLoadWatchlistStatus(tId)),
    expect: () => [
      AlreadyOnWatchlist(),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'Should emit [NotOnWatchlist] when get status returning false',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => false);
      return movieDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieLoadWatchlistStatus(tId)),
    expect: () => [
      NotOnWatchlist(),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );
}
