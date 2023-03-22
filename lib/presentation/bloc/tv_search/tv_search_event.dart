part of 'tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTvProgram extends TvSearchEvent {
  final String query;

  SearchTvProgram(this.query);

  @override
  List<Object> get props => [];
}

class ClearSearchTv extends TvSearchEvent {}
