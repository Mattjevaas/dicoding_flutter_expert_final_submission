import 'package:ditonton/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => BlocProvider.of<MovieWatchlistBloc>(context).add(
        FetchWatchlistMovie(),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<MovieWatchlistBloc>(context).add(FetchWatchlistMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
          builder: (context, state) {
            if (state is MovieWatchlistLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieWatchlistHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.watchlist[index];

                  if (movie.redirect != null) {
                    if (movie.redirect == "movie")
                      return MovieCard(
                        key: ValueKey(movie.id),
                        movie,
                      );
                    if (movie.redirect == "tv")
                      return TvCard(
                        Tv.watchlist(
                            id: movie.id,
                            overview: movie.overview!,
                            posterPath: movie.posterPath,
                            name: movie.title!),
                        key: ValueKey(
                          movie.id,
                        ),
                      );
                  }
                  return MovieCard(
                    key: ValueKey(movie.id),
                    movie,
                  );
                },
                itemCount: state.watchlist.length,
              );
            } else if (state is MovieWatchlistError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text("Nothing Found"),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
