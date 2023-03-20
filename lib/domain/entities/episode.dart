import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  Episode({
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.stillPath,
  });

  final int episodeNumber;
  final int id;
  final String name;
  final String? stillPath;

  @override
  List<Object?> get props => [
        episodeNumber,
        id,
        name,
        stillPath,
      ];
}
