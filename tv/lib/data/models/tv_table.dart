import 'package:equatable/equatable.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';

class TvTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? redirect;

  const TvTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.redirect,
  });

  factory TvTable.fromEntity(TvDetail movie) => TvTable(
        id: movie.id,
        title: movie.name,
        posterPath: movie.posterPath,
        overview: movie.overview,
        redirect: "tv",
      );

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        redirect: map['redirect'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'redirect': "tv",
      };

  Tv toEntity() => Tv.watchlist(
        id: id,
        overview: overview!,
        posterPath: posterPath,
        name: title!,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
