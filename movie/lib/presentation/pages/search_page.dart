import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants.dart';
import '../bloc/movie_search/movie_search_bloc.dart';
import '../widgets/movie_card_list.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<MovieSearchBloc>(context).add(ClearSearchMovie());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onSubmitted: (query) {
                  BlocProvider.of<MovieSearchBloc>(context)
                      .add(SearchMovie(query));
                },
                decoration: const InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 16),
              Text(
                'Search Result',
                style: kHeading6,
              ),
              BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (context, state) {
                  if (state is MovieSearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieSearchHasData) {
                    final result = state.searchResult;

                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = result[index];
                          return MovieCard(
                            key: ValueKey(movie.id),
                            movie,
                          );
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
