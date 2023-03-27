part of 'tv_detail_watchlist_bloc.dart';

abstract class TvDetailWatchlistEvent extends Equatable {
  const TvDetailWatchlistEvent();
}

class TvAddWatchList extends TvDetailWatchlistEvent {
  final TvDetail tvDetail;

  const TvAddWatchList(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class TvRemoveWatchList extends TvDetailWatchlistEvent {
  final TvDetail tvDetail;

  const TvRemoveWatchList(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class TvLoadWatchlistStatus extends TvDetailWatchlistEvent {
  final int id;

  const TvLoadWatchlistStatus(this.id);

  @override
  List<Object?> get props => [id];
}
