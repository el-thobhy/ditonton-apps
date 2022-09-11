import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:core/domain/repositories/tv_show_repository.dart';

class RemoveWatchlist {
  final TvRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
