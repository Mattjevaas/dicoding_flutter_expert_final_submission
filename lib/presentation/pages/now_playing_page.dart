import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/now_playing_tv_notifier.dart';

class NowPlayingTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/nowplaying-tv';

  @override
  _NowPlayingTvsPageState createState() => _NowPlayingTvsPageState();
}

class _NowPlayingTvsPageState extends State<NowPlayingTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayingTvsNotifier>(context, listen: false)
            .fetchNowPlayingTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NowPlaying Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingTvsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvs[index];
                  return TvCard(tv);
                },
                itemCount: data.tvs.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
