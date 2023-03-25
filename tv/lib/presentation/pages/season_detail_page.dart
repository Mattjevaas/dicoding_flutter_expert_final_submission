import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants.dart';
import '../../domain/entities/season_detail.dart';
import '../bloc/tv_season_detail/tv_season_detail_bloc.dart';

class SeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/season';

  final int tvId;
  final int seasonNum;

  SeasonDetailPage({required this.tvId, required this.seasonNum});

  @override
  _SeasonDetailPageState createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvSeasonDetailBloc>(context).add(FetchTvSeasonDetail(
        id: widget.tvId,
        seasonNum: widget.seasonNum,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeasonDetailBloc, TvSeasonDetailState>(
        builder: (context, state) {
          if (state is TvSeasonDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeasonDetailHasData) {
            final season = state.seasonDetail;

            return SafeArea(
              child: SeasonDetailContent(
                season,
              ),
            );
          } else if (state is TvSeasonDetailEmpty) {
            return Text("Data Kosong");
          } else {
            final newState = state as TvSeasonDetailError;
            return Text(newState.message);
          }
        },
      ),
    );
  }
}

class SeasonDetailContent extends StatelessWidget {
  final SeasonDetail season;

  SeasonDetailContent(this.season);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              season.name,
                              style: kHeading5,
                            ),
                            if (season.overview.isNotEmpty)
                              SizedBox(height: 16),
                            if (season.overview.isNotEmpty)
                              Text(
                                'Overview',
                                style: kHeading6,
                              ),
                            if (season.overview.isNotEmpty)
                              Text(
                                season.overview,
                              ),
                            if (season.episodes.isNotEmpty)
                              SizedBox(height: 16),
                            if (season.overview.isNotEmpty)
                              Text(
                                'Episodes',
                                style: kHeading6,
                              ),
                            if (season.overview.isNotEmpty)
                              SizedBox(height: 25),
                            if (season.overview.isNotEmpty)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 500,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    final data = season.episodes[index];

                                    return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${data.stillPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                height: 80,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "E${data.episodeNumber} - ${data.name}",
                                                    style: kSubtitle,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ));
                                  },
                                  itemCount: season.episodes.length,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
