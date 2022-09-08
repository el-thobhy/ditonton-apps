// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton_apps/test/presentation/provider/movie_list_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as i5;

import 'package:dartz/dartz.dart' as i3;
import 'package:core/common/failure.dart' as i6;
import 'package:core/domain/entities/movie.dart' as i7;
import 'package:core/domain/repositories/movie_repository.dart' as i2;
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart'
    as i4;
import 'package:core/domain/usecases/movie/get_popular_movies.dart' as i8;
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart'
    as i9;
import 'package:mockito/mockito.dart' as i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieRepository_0 extends i1.Fake implements i2.MovieRepository {}

class _FakeEither_1<L, R> extends i1.Fake implements i3.Either<L, R> {}

/// A class which mocks [GetNowPlayingMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingMovies extends i1.Mock
    implements i4.GetNowPlayingMovies {
  MockGetNowPlayingMovies() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i7.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<i3.Either<i6.Failure, List<i7.Movie>>>.value(
              _FakeEither_1<i6.Failure, List<i7.Movie>>())) as i5
          .Future<i3.Either<i6.Failure, List<i7.Movie>>>);
}

/// A class which mocks [GetPopularMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularMovies extends i1.Mock implements i8.GetPopularMovies {
  MockGetPopularMovies() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i7.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<i3.Either<i6.Failure, List<i7.Movie>>>.value(
              _FakeEither_1<i6.Failure, List<i7.Movie>>())) as i5
          .Future<i3.Either<i6.Failure, List<i7.Movie>>>);
}

/// A class which mocks [GetTopRatedMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedMovies extends i1.Mock implements i9.GetTopRatedMovies {
  MockGetTopRatedMovies() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i7.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<i3.Either<i6.Failure, List<i7.Movie>>>.value(
              _FakeEither_1<i6.Failure, List<i7.Movie>>())) as i5
          .Future<i3.Either<i6.Failure, List<i7.Movie>>>);
}
