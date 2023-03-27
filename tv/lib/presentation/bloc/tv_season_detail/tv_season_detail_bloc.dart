import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/season_detail.dart';
import '../../../domain/usecases/get_season_detail.dart';

part 'tv_season_detail_event.dart';
part 'tv_season_detail_state.dart';

class TvSeasonDetailBloc
    extends Bloc<TvSeasonDetailEvent, TvSeasonDetailState> {
  final GetSeasonDetail _getTvSeasonDetail;

  TvSeasonDetailBloc({
    required GetSeasonDetail getTvSeasonDetail,
  })  : _getTvSeasonDetail = getTvSeasonDetail,
        super(TvSeasonDetailEmpty()) {
    on<FetchTvSeasonDetail>((event, emit) async {
      emit(TvSeasonDetailLoading());
      final result = await _getTvSeasonDetail.execute(
        tvId: event.id,
        seasonNum: event.seasonNum,
      );

      result.fold(
        (failure) => emit(TvSeasonDetailError(failure.message)),
        (data) async {
          emit(TvSeasonDetailHasData(data));
        },
      );
    });
  }
}
