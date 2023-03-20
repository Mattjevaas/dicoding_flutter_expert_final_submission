import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  EpisodeModel({
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.stillPath,
  });

  final int episodeNumber;
  final int id;
  final String name;
  final String? stillPath;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        stillPath: json["still_path"],
      );

  Map<String, dynamic> toJson() => {
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "still_path": stillPath,
      };

  @override
  List<Object?> get props => [
        episodeNumber,
        id,
        name,
        stillPath,
      ];
}
