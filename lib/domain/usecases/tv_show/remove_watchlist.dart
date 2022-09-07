import 'package:dartz/dartz.dart';
import 'package:ditonton_apps/common/failure.dart';
import 'package:ditonton_apps/domain/entities/tv_show_detail.dart';
import 'package:ditonton_apps/domain/repositories/tv_show_repository.dart';

class RemoveWatchlist {
  final TvRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
