part of 'tv_list_bloc.dart';

abstract class TvListState extends Equatable {
  const TvListState();

  @override
  List<Object?> get props => [];
}

class TvListEmpty extends TvListState {}

class TvListLoading extends TvListState {}

class TvListError extends TvListState {
  final String message;

  TvListError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvListHasData extends TvListState {
  final List<Tv> nowPlaying;
  final List<Tv> popular;
  final List<Tv> topRated;

  TvListHasData({
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
