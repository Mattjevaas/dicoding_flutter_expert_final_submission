import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_watchlist/tv_detail_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatusTv, SaveWatchlistTv, RemoveWatchlistTv])
void main() {
  late MockGetWatchListStatusTv mockGetWatchListStatus;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;

  late TvDetailWatchlistBloc tvDetailWatchlistBloc;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatusTv();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();

    tvDetailWatchlistBloc = TvDetailWatchlistBloc(
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
      getWatchListStatus: mockGetWatchListStatus,
    );
  });

  final tId = 1;

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'Should emit [AlreadyOnWatchlist] when get add is success',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right('success'));
      return tvDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvAddWatchList(testTvDetail)),
    expect: () => [
      AlreadyOnWatchlist(),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'Should emit [WatchlistError] when get add is failed',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('fail')));
      return tvDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvAddWatchList(testTvDetail)),
    expect: () => [
      WatchlistError('fail'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'Should emit [NotOnWatchlist] when get remove is success',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right('success'));
      return tvDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvRemoveWatchList(testTvDetail)),
    expect: () => [
      NotOnWatchlist(),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'Should emit [WatchlistError] when get remove is failed',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('fail')));
      return tvDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvRemoveWatchList(testTvDetail)),
    expect: () => [WatchlistError('fail')],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'Should emit [AlreadyOnWatchList] when get status returning true',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return tvDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvLoadWatchlistStatus(tId)),
    expect: () => [
      AlreadyOnWatchlist(),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'Should emit [NotOnWatchlist] when get status returning false',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => false);
      return tvDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvLoadWatchlistStatus(tId)),
    expect: () => [
      NotOnWatchlist(),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );
}
