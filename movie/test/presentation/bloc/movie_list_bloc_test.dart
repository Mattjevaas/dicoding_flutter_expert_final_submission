import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/common/failure.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_state.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc movieListBloc;

  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListBloc = MovieListBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  blocTest<MovieListBloc, MovieListState>(
    'Should emit [Loading,HasData] when get fetch is success',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));

      return movieListBloc;
    },
    act: (bloc) => bloc.add(FetchMovieList()),
    expect: () => [
      MovieListLoading(),
      MovieListHasData(
        nowPlaying: tMovieList,
        popular: tMovieList,
        topRated: tMovieList,
      ),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
      verify(mockGetTopRatedMovies.execute());
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'Should emit [Loading,Error] when get fetch is failed',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('fail')));
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('fail')));
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('fail')));

      return movieListBloc;
    },
    act: (bloc) => bloc.add(FetchMovieList()),
    expect: () => [MovieListLoading(), MovieListError('fail')],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
      verify(mockGetTopRatedMovies.execute());
      verify(mockGetPopularMovies.execute());
    },
  );
}
