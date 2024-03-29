import 'package:dartz/dartz.dart';
import 'package:tv/common/failure.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetNowPlayingTv {
  final TvRepository repository;

  GetNowPlayingTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTv();
  }
}
