import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailWatchlistEvent extends Equatable {
  const MovieDetailWatchlistEvent();

  @override
  List<Object?> get props => [];
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
