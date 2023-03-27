import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tv_now_playing/tv_now_playing_bloc.dart';
import '../widgets/tv_card_list.dart';

class NowPlayingTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/nowplaying-tv';

  const NowPlayingTvsPage({super.key});

  @override
  _NowPlayingTvsPageState createState() => _NowPlayingTvsPageState();
}

class _NowPlayingTvsPageState extends State<NowPlayingTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => BlocProvider.of<TvNowPlayingBloc>(context).add(
        FetchTvNowPlayingMovie(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NowPlaying Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(
          builder: (context, state) {
            if (state is TvNowPlayingLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvNowPlayingHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.nowPlaying[index];
                  return TvCard(
                    key: ValueKey(
                      movie.id,
                    ),
                    movie,
                  );
                },
                itemCount: state.nowPlaying.length,
              );
            } else if (state is TvNowPlayingError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text("Nothing Found"),
              );
            }
          },
        ),
      ),
    );
  }
}
