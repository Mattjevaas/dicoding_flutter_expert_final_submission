import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_top_rated_tv.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTv _getTopRatedTv;

  TvTopRatedBloc({required GetTopRatedTv getTopRatedTv})
      : _getTopRatedTv = getTopRatedTv,
        super(TvTopRatedEmpty()) {
    on<FetchTvTopRatedMovie>((event, emit) async {
      emit(TvTopRatedLoading());

      final result = await _getTopRatedTv.execute();

      result.fold(
        (l) => emit(TvTopRatedError(l.message)),
        (r) => emit(TvTopRatedHasData(r)),
      );
    });
  }
}
