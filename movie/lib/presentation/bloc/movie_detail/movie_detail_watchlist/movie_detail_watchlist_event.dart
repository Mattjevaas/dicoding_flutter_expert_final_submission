import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie_detail.dart';

abstract class MovieDetailWatchlistEvent extends Equatable {
  const MovieDetailWatchlistEvent();
}

class MovieAddWatchList extends MovieDetailWatchlistEvent {
  final MovieDetail movieDetail;

  MovieAddWatchList(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class MovieRemoveWatchList extends MovieDetailWatchlistEvent {
  final MovieDetail movieDetail;

  MovieRemoveWatchList(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class MovieLoadWatchlistStatus extends MovieDetailWatchlistEvent {
  final int id;

  MovieLoadWatchlistStatus(this.id);

  @override
  List<Object?> get props => [id];
}
