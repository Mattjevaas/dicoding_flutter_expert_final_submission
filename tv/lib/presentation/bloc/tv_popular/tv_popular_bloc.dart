import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_popular_tv.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTv _getPopularTv;

  TvPopularBloc({required GetPopularTv getPopularTv})
      : _getPopularTv = getPopularTv,
        super(TvPopularEmpty()) {
    on<FetchTvPopularMovie>((event, emit) async {
      emit(TvPopularLoading());

      final result = await _getPopularTv.execute();

      result.fold(
        (l) => emit(TvPopularError(l.message)),
        (r) => emit(TvPopularHasData(r)),
      );
    });
  }
}
