import 'package:dartz/dartz.dart';
import 'package:ditonton_apps/common/failure.dart';
import 'package:ditonton_apps/domain/entities/movie.dart';
import 'package:ditonton_apps/domain/repositories/movie_repository.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
