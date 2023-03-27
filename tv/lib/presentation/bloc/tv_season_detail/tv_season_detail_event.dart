part of 'tv_season_detail_bloc.dart';

abstract class TvSeasonDetailEvent extends Equatable {
  const TvSeasonDetailEvent();
}

class FetchTvSeasonDetail extends TvSeasonDetailEvent {
  final int id;
  final int seasonNum;

  const FetchTvSeasonDetail({
    required this.id,
    required this.seasonNum,
  });

  @override
  List<Object?> get props => [id, seasonNum];
}
