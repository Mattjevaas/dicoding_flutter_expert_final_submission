import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tv_detail.dart';
import '../../../../domain/usecases/get_watchlist_status_tv.dart';
import '../../../../domain/usecases/remove_watchlist_tv.dart';
import '../../../../domain/usecases/save_watchlist_tv.dart';

part 'tv_detail_watchlist_event.dart';
part 'tv_detail_watchlist_state.dart';

class TvDetailWatchlistBloc
    extends Bloc<TvDetailWatchlistEvent, TvDetailWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  static const watchlistErrorMessage = 'Failed to do action';

  final GetWatchListStatusTv _getWatchListStatus;
  final SaveWatchlistTv _saveWatchlist;
  final RemoveWatchlistTv _removeWatchlist;

  TvDetailWatchlistBloc({
    required GetWatchListStatusTv getWatchListStatus,
    required SaveWatchlistTv saveWatchlist,
    required RemoveWatchlistTv removeWatchlist,
  })  : _getWatchListStatus = getWatchListStatus,
        _saveWatchlist = saveWatchlist,
        _removeWatchlist = removeWatchlist,
        super(NotOnWatchlist()) {
    on<TvAddWatchList>(
      (event, emit) async {
        emit(UpdatingWatchlist());
        final result = await _saveWatchlist.execute(event.tvDetail);
        result.fold(
          (failure) => emit(WatchlistError(failure.message)),
          (_) => emit(AlreadyOnWatchlist()),
        );
      },
    );
    on<TvRemoveWatchList>(
      (event, emit) async {
        emit(UpdatingWatchlist());
        final result = await _removeWatchlist.execute(event.tvDetail);
        result.fold(
          (failure) => emit(WatchlistError(failure.message)),
          (_) => emit(NotOnWatchlist()),
        );
      },
    );
    on<TvLoadWatchlistStatus>(
      (event, emit) async {
        final result = await _getWatchListStatus.execute(event.id);
        if (result) {
          emit(AlreadyOnWatchlist());
        } else {
          emit(NotOnWatchlist());
        }
      },
    );
  }
}
