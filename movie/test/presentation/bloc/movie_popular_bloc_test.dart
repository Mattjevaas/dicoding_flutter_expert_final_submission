import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/common/failure.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/movie_popular/movie_popular_bloc.dart';

import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;

  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(getPopularMovies: mockGetPopularMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
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

  blocTest<MoviePopularBloc, MoviePopularState>(
    'Should emit [Loading,HasData] when get fetch is success',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovie()),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'Should emit [Loading, Error] when get fetch is failed',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('fail')));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovie()),
    expect: () => [
      MoviePopularLoading(),
      const MoviePopularError('fail'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
