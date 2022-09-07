import 'package:dartz/dartz.dart';
import 'package:ditonton_apps/domain/entities/movie.dart';
import 'package:ditonton_apps/domain/repositories/movie_repository.dart';
import 'package:ditonton_apps/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
