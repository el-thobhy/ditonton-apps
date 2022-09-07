import 'package:dartz/dartz.dart';
import 'package:ditonton_apps/common/failure.dart';
import 'package:ditonton_apps/domain/entities/tv_show.dart';
import 'package:ditonton_apps/domain/repositories/tv_show_repository.dart';

class SearchTv {
  final TvRepository repository;

  SearchTv(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(String query) {
    return repository.searchTv(query);
  }
}
