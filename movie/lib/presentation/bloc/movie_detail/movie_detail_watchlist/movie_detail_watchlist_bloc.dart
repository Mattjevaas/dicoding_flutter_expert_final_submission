import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_watchlist_status.dart';
import '../../../../domain/usecases/remove_watchlist.dart';
import '../../../../domain/usecases/save_watchlist.dart';
import 'movie_detail_watchlist_event.dart';
import 'movie_detail_watchlist_state.dart';

class MovieDetailWatchlistBloc
    extends Bloc<MovieDetailWatchlistEvent, MovieDetailWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  static const watchlistErrorMessage = 'Failed to do action';

  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieDetailWatchlistBloc({
    required GetWatchListStatus getWatchListStatus,
    required SaveWatchlist saveWatchlist,
    required RemoveWatchlist removeWatchlist,
  })  : _getWatchListStatus = getWatchListStatus,
        _saveWatchlist = saveWatchlist,
        _removeWatchlist = removeWatchlist,
        super(NotOnWatchlist()) {
    on<MovieAddWatchList>(
      (event, emit) async {
        final result = await _saveWatchlist.execute(event.movieDetail);
        result.fold(
          (failure) => emit(WatchlistError(failure.message)),
          (_) => emit(AlreadyOnWatchlist()),
        );
      },
    );
    on<MovieRemoveWatchList>(
      (event, emit) async {
        final result = await _removeWatchlist.execute(event.movieDetail);
        result.fold(
          (failure) => emit(WatchlistError(failure.message)),
          (_) => emit(NotOnWatchlist()),
        );
      },
    );
    on<MovieLoadWatchlistStatus>(
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
