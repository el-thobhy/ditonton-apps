import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:core/domain/repositories/tv_show_repository.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvShowDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
