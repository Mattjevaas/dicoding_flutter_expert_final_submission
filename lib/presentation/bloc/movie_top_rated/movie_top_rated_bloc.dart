import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc({required GetTopRatedMovies getTopRatedMovies})
      : _getTopRatedMovies = getTopRatedMovies,
        super(MovieTopRatedEmpty()) {
    on<FetchTopRatedMovie>((event, emit) async {
      emit(MovieTopRatedLoading());

      final result = await _getTopRatedMovies.execute();

      result.fold(
        (l) => emit(MovieTopRatedError(l.message)),
        (r) => emit(MovieTopRatedHasData(r)),
      );
    });
  }
}
