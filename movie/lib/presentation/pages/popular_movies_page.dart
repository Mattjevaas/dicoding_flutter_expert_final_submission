import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_popular/movie_popular_bloc.dart';
import '../widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => BlocProvider.of<MoviePopularBloc>(context).add(
        FetchPopularMovie(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
          builder: (context, state) {
            if (state is MoviePopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviePopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.popular[index];
                  return MovieCard(movie);
                },
                itemCount: state.popular.length,
              );
            } else if (state is MoviePopularError) {
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
}