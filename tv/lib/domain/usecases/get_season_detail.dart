import 'package:dartz/dartz.dart';
import 'package:tv/common/failure.dart';

import '../entities/season_detail.dart';
import '../repositories/tv_repository.dart';

class GetSeasonDetail {
  final TvRepository repository;

  GetSeasonDetail(this.repository);

  Future<Either<Failure, SeasonDetail>> execute({
    required int tvId,
    required int seasonNum,
  }) {
    return repository.getSeasonDetail(tvId: tvId, seasonNum: seasonNum);
  }
}
