import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_now_playing_tv.dart';
import '../../../domain/usecases/get_popular_tv.dart';
import '../../../domain/usecases/get_top_rated_tv.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetNowPlayingTv _getNowPlayingTvs;
  final GetPopularTv _getPopularTvs;
  final GetTopRatedTv _getTopRatedTvs;

  TvListBloc({
    required GetNowPlayingTv getNowPlayingTvs,
    required GetPopularTv getPopularTvs,
    required GetTopRatedTv getTopRatedTvs,
  })  : _getNowPlayingTvs = getNowPlayingTvs,
        _getPopularTvs = getPopularTvs,
        _getTopRatedTvs = getTopRatedTvs,
        super(TvListEmpty()) {
    on<FetchTvList>((event, emit) async {
      emit(TvListLoading());
      final result = await _getNowPlayingTvs.execute();
      final resultPopular = await _getPopularTvs.execute();
      final resultTopRated = await _getTopRatedTvs.execute();

      result.fold(
        (failure) => emit(TvListError(failure.message)),
        (data) async {
          resultPopular.fold(
            (failurePopular) => emit(
              TvListError(failurePopular.message),
            ),
            (dataPopular) {
              resultTopRated.fold(
                (failureTopRated) => emit(
                  TvListError(failureTopRated.message),
                ),
                (dataTopRated) => emit(
                  TvListHasData(
                    nowPlaying: data,
                    popular: dataPopular,
                    topRated: dataTopRated,
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
