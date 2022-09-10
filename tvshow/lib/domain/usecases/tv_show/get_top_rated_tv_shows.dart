import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/repositories/tv_show_repository.dart';

class GetTopRatedTv {
  final TvRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getTopRatedTv();
  }
}
