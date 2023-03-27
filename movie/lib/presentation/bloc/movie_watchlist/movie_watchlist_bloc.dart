import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_watchlist_movies.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;

  MovieWatchlistBloc({required GetWatchlistMovies getWatchlistMovies})
      : _getWatchlistMovies = getWatchlistMovies,
        super(MovieWatchlistEmpty()) {
    on<FetchWatchlistMovie>((event, emit) async {
      emit(MovieWatchlistLoading());

      final result = await _getWatchlistMovies.execute();

      result.fold(
        (l) => emit(MovieWatchlistError(l.message)),
        (r) => emit(MovieWatchlistHasData(r)),
      );
    });
  }
}
