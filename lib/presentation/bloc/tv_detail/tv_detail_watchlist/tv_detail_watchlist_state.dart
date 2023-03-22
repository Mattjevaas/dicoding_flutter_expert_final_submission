part of 'tv_detail_watchlist_bloc.dart';

abstract class TvDetailWatchlistState extends Equatable {
  const TvDetailWatchlistState();

  @override
  List<Object?> get props => [];
}

class AlreadyOnWatchlist extends TvDetailWatchlistState {}

class NotOnWatchlist extends TvDetailWatchlistState {}

class WatchlistError extends TvDetailWatchlistState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}
