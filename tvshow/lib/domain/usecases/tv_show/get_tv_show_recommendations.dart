import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/repositories/tv_show_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
