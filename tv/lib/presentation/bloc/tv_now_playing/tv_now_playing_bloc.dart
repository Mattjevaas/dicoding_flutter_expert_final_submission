import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_now_playing_tv.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetNowPlayingTv _getNowPlayingTv;

  TvNowPlayingBloc({required GetNowPlayingTv getNowPlayingTv})
      : _getNowPlayingTv = getNowPlayingTv,
        super(TvNowPlayingEmpty()) {
    on<FetchTvNowPlayingMovie>((event, emit) async {
      emit(TvNowPlayingLoading());

      final result = await _getNowPlayingTv.execute();

      result.fold(
        (l) => emit(TvNowPlayingError(l.message)),
        (r) => emit(TvNowPlayingHasData(r)),
      );
    });
  }
}
