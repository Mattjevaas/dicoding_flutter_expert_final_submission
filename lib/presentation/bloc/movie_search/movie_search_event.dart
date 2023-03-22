part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMovie extends MovieSearchEvent {
  final String query;

  SearchMovie(this.query);

  @override
  List<Object> get props => [];
}

class ClearSearchMovie extends MovieSearchEvent {}
