import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movies.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc({required GetPopularMovies getPopularMovies})
      : _getPopularMovies = getPopularMovies,
        super(MoviePopularEmpty()) {
    on<FetchPopularMovie>((event, emit) async {
      emit(MoviePopularLoading());

      final result = await _getPopularMovies.execute();

      result.fold(
        (l) => emit(MoviePopularError(l.message)),
        (r) => emit(MoviePopularHasData(r)),
      );
    });
  }
}
