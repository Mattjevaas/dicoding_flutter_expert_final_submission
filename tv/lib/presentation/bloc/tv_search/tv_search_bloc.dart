import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/search_tv.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv _searchTvs;

  TvSearchBloc({
    required SearchTv searchTvs,
  })  : _searchTvs = searchTvs,
        super(TvSearchEmpty()) {
    on<SearchTvProgram>(
      (event, emit) async {
        emit(TvSearchLoading());

        final searchData = await _searchTvs.execute(event.query);

        searchData.fold(
          (failure) => emit(TvSearchError(failure.message)),
          (data) => emit(TvSearchHasData(data)),
        );
      },
    );
    on<ClearSearchTv>((event, emit) => emit(TvSearchEmpty()));
  }
}
