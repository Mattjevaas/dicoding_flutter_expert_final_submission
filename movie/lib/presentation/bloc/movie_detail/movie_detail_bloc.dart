import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;

  MovieDetailBloc({
    required GetMovieDetail getMovieDetail,
    required GetMovieRecommendations getMovieRecommendations,
  })  : _getMovieDetail = getMovieDetail,
        _getMovieRecommendations = getMovieRecommendations,
        super(MovieDetailEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      final result = await _getMovieDetail.execute(event.id);
      final resultRec = await _getMovieRecommendations.execute(event.id);

      result.fold(
        (failure) => emit(MovieDetailError(failure.message)),
        (data) async {
          resultRec.fold(
            (failureRec) => emit(
              MovieDetailError(failureRec.message),
            ),
            (dataRec) {
              emit(MovieDetailHasData(data, dataRec));
            },
          );
        },
      );
    });
  }
}
