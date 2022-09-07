import 'package:dartz/dartz.dart';
import 'package:ditonton_apps/common/failure.dart';
import 'package:ditonton_apps/domain/entities/tv_show.dart';
import 'package:ditonton_apps/domain/repositories/tv_show_repository.dart';

class GetNowPlayingTv {
  final TvRepository repository;

  GetNowPlayingTv(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getNowPlayingTv();
  }
}
