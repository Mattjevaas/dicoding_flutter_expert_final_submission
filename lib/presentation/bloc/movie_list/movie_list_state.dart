import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object?> get props => [];
}

class MovieListEmpty extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListError extends MovieListState {
  final String message;

  MovieListError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieListlHasData extends MovieListState {
  final List<Movie> nowPlaying;
  final List<Movie> popular;
  final List<Movie> topRated;

  MovieListlHasData({
    required this.nowPlaying,
    required this.popular,
    required this.topRated,
  });

  @override
  List<Object?> get props => [
        nowPlaying,
        popular,
        topRated,
      ];
}
