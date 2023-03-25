import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/entities/tv_detail.dart';
import '../../../domain/usecases/get_tv_detail.dart';
import '../../../domain/usecases/get_tv_recommendations.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;
  final GetTvRecommendations _getTvRecommendations;

  TvDetailBloc({
    required GetTvDetail getTvDetail,
    required GetTvRecommendations getTvRecommendations,
  })  : _getTvDetail = getTvDetail,
        _getTvRecommendations = getTvRecommendations,
        super(TvDetailEmpty()) {
    on<FetchTvDetail>((event, emit) async {
      emit(TvDetailLoading());
      final result = await _getTvDetail.execute(event.id);
      final resultRec = await _getTvRecommendations.execute(event.id);

      result.fold(
        (failure) => emit(TvDetailError(failure.message)),
        (data) async {
          resultRec.fold(
            (failureRec) => emit(
              TvDetailError(failureRec.message),
            ),
            (dataRec) {
              emit(TvDetailHasData(data, dataRec));
            },
          );
        },
      );
    });
  }
}
