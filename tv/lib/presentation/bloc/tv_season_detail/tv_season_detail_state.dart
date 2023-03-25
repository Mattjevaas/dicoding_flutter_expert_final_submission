part of 'tv_season_detail_bloc.dart';

abstract class TvSeasonDetailState extends Equatable {
  const TvSeasonDetailState();

  @override
  List<Object> get props => [];
}

class TvSeasonDetailEmpty extends TvSeasonDetailState {}

class TvSeasonDetailLoading extends TvSeasonDetailState {}

class TvSeasonDetailError extends TvSeasonDetailState {
  final String message;

  TvSeasonDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeasonDetailHasData extends TvSeasonDetailState {
  final SeasonDetail seasonDetail;

  TvSeasonDetailHasData(this.seasonDetail);

  @override
  List<Object> get props => [seasonDetail];
}
