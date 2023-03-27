import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/search_movies.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies _searchMovies;

  MovieSearchBloc({
    required SearchMovies searchMovies,
  })  : _searchMovies = searchMovies,
        super(MovieSearchEmpty()) {
    on<SearchMovie>(
      (event, emit) async {
        emit(MovieSearchLoading());

        final searchData = await _searchMovies.execute(event.query);

        searchData.fold(
          (failure) => emit(MovieSearchError(failure.message)),
          (data) => emit(MovieSearchHasData(data)),
        );
      },
    );
    on<ClearSearchMovie>((event, emit) => emit(MovieSearchEmpty()));
  }
}
