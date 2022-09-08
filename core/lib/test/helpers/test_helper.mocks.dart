// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton_apps/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as i7;
import 'dart:convert' as i24;
import 'dart:typed_data' as i25;

import 'package:dartz/dartz.dart' as i2;
import 'package:core/common/failure.dart' as i8;
import 'package:core/data/datasources/db/database_helper.dart' as i22;
import 'package:core/data/datasources/movie_local_data_source.dart' as i18;
import 'package:core/data/datasources/movie_remote_data_source.dart'
    as i14;
import 'package:core/data/datasources/tv_show_local_data_source.dart'
    as i20;
import 'package:core/data/datasources/tv_show_remote_data_source.dart'
    as i16;
import 'package:core/data/models/movie_detail_model.dart' as i3;
import 'package:core/data/models/movie_model.dart' as i15;
import 'package:core/data/models/movie_table.dart' as i19;
import 'package:core/data/models/tv_show_detail_model.dart' as i4;
import 'package:core/data/models/tv_show_model.dart' as i17;
import 'package:core/data/models/tv_show_table.dart' as i21;
import 'package:core/domain/entities/movie.dart' as i9;
import 'package:core/domain/entities/movie_detail.dart' as i10;
import 'package:core/domain/entities/tv_show.dart' as i12;
import 'package:core/domain/entities/tv_show_detail.dart' as i13;
import 'package:core/domain/repositories/movie_repository.dart' as i6;
import 'package:core/domain/repositories/tv_show_repository.dart' as i11;
import 'package:http/http.dart' as i5;
import 'package:mockito/mockito.dart' as i1;
import 'package:sqflite/sqflite.dart' as i23;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends i1.Fake implements i2.Either<L, R> {}

class _FakeMovieDetailResponse_1 extends i1.Fake
    implements i3.MovieDetailResponse {}

class _FakeTVShowDetailResponse_2 extends i1.Fake
    implements i4.TvDetailResponse {}

class _FakeResponse_3 extends i1.Fake implements i5.Response {}

class _FakeStreamedResponse_4 extends i1.Fake implements i5.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends i1.Mock implements i6.MovieRepository {
  MockMovieRepository() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<i2.Either<i8.Failure, List<i9.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<i2.Either<i8.Failure, List<i9.Movie>>>.value(
              _FakeEither_0<i8.Failure, List<i9.Movie>>())) as i7
          .Future<i2.Either<i8.Failure, List<i9.Movie>>>);
  @override
  i7.Future<i2.Either<i8.Failure, List<i9.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<i2.Either<i8.Failure, List<i9.Movie>>>.value(
              _FakeEither_0<i8.Failure, List<i9.Movie>>())) as i7
          .Future<i2.Either<i8.Failure, List<i9.Movie>>>);
  @override
  i7.Future<i2.Either<i8.Failure, List<i9.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<i2.Either<i8.Failure, List<i9.Movie>>>.value(
              _FakeEither_0<i8.Failure, List<i9.Movie>>())) as i7
          .Future<i2.Either<i8.Failure, List<i9.Movie>>>);
  @override
  i7.Future<i2.Either<i8.Failure, i10.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<i2.Either<i8.Failure, i10.MovieDetail>>.value(
              _FakeEither_0<i8.Failure, i10.MovieDetail>())) as i7
          .Future<i2.Either<i8.Failure, i10.MovieDetail>>);
  @override
  i7.Future<i2.Either<i8.Failure, List<i9.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<i2.Either<i8.Failure, List<i9.Movie>>>.value(
              _FakeEither_0<i8.Failure, List<i9.Movie>>())) as i7
          .Future<i2.Either<i8.Failure, List<i9.Movie>>>);
  @override
  i7.Future<i2.Either<i8.Failure, List<i9.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<i2.Either<i8.Failure, List<i9.Movie>>>.value(
              _FakeEither_0<i8.Failure, List<i9.Movie>>())) as i7
          .Future<i2.Either<i8.Failure, List<i9.Movie>>>);
  @override
  i7.Future<i2.Either<i8.Failure, String>> saveWatchlist(
          i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<i2.Either<i8.Failure, String>>.value(
                  _FakeEither_0<i8.Failure, String>()))
          as i7.Future<i2.Either<i8.Failure, String>>);
  @override
  i7.Future<i2.Either<i8.Failure, String>> removeWatchlist(
          i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<i2.Either<i8.Failure, String>>.value(
                  _FakeEither_0<i8.Failure, String>()))
          as i7.Future<i2.Either<i8.Failure, String>>);
  @override
  i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as i7.Future<bool>);
  @override
  i7.Future<i2.Either<i8.Failure, List<i9.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<i2.Either<i8.Failure, List<i9.Movie>>>.value(
              _FakeEither_0<i8.Failure, List<i9.Movie>>())) as i7
          .Future<i2.Either<i8.Failure, List<i9.Movie>>>);
}

/// A class which mocks [TVShowRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVShowRepository extends i1.Mock implements i11.TvRepository {
  MockTVShowRepository() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<i2.Either<i8.Failure, List<i12.TvShow>>>
      getNowPlayingTv() => (super.noSuchMethod(
          Invocation.method(#getNowPlayingTVShows, []),
          returnValue: Future<i2.Either<i8.Failure, List<i12.TvShow>>>.value(
              _FakeEither_0<i8.Failure, List<i12.TvShow>>())) as i7
          .Future<i2.Either<i8.Failure, List<i12.TvShow>>>);
  @override
  i7.Future<i2.Either<i8.Failure, List<i12.TvShow>>> getPopularTv() =>
      (super.noSuchMethod(Invocation.method(#getPopularTVShows, []),
          returnValue: Future<i2.Either<i8.Failure, List<i12.TvShow>>>.value(
              _FakeEither_0<i8.Failure, List<i12.TvShow>>())) as i7
          .Future<i2.Either<i8.Failure, List<i12.TvShow>>>);
  @override
  i7.Future<i2.Either<i8.Failure, List<i12.TvShow>>> getTopRatedTv() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTVShows, []),
          returnValue: Future<i2.Either<i8.Failure, List<i12.TvShow>>>.value(
              _FakeEither_0<i8.Failure, List<i12.TvShow>>())) as i7
          .Future<i2.Either<i8.Failure, List<i12.TvShow>>>);
  @override
  i7.Future<i2.Either<i8.Failure, i13.TvShowDetail>> getTvDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVShowDetail, [id]),
          returnValue: Future<i2.Either<i8.Failure, i13.TvShowDetail>>.value(
              _FakeEither_0<i8.Failure, i13.TvShowDetail>())) as i7
          .Future<i2.Either<i8.Failure, i13.TvShowDetail>>);
  @override
  i7.Future<i2.Either<i8.Failure, List<i12.TvShow>>>
      getTvRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getTVShowRecommendations, [id]),
          returnValue: Future<i2.Either<i8.Failure, List<i12.TvShow>>>.value(
              _FakeEither_0<i8.Failure, List<i12.TvShow>>())) as i7
          .Future<i2.Either<i8.Failure, List<i12.TvShow>>>);
  @override
  i7.Future<i2.Either<i8.Failure, List<i12.TvShow>>> searchTv(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTVShows, [query]),
          returnValue: Future<i2.Either<i8.Failure, List<i12.TvShow>>>.value(
              _FakeEither_0<i8.Failure, List<i12.TvShow>>())) as i7
          .Future<i2.Either<i8.Failure, List<i12.TvShow>>>);
  @override
  i7.Future<i2.Either<i8.Failure, String>> saveWatchlist(
          i13.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tvShow]),
              returnValue: Future<i2.Either<i8.Failure, String>>.value(
                  _FakeEither_0<i8.Failure, String>()))
          as i7.Future<i2.Either<i8.Failure, String>>);
  @override
  i7.Future<i2.Either<i8.Failure, String>> removeWatchlist(
          i13.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvShow]),
              returnValue: Future<i2.Either<i8.Failure, String>>.value(
                  _FakeEither_0<i8.Failure, String>()))
          as i7.Future<i2.Either<i8.Failure, String>>);
  @override
  i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as i7.Future<bool>);
  @override
  i7.Future<i2.Either<i8.Failure, List<i12.TvShow>>>
      getWatchlistTv() => (super.noSuchMethod(
          Invocation.method(#getWatchlistTVShows, []),
          returnValue: Future<i2.Either<i8.Failure, List<i12.TvShow>>>.value(
              _FakeEither_0<i8.Failure, List<i12.TvShow>>())) as i7
          .Future<i2.Either<i8.Failure, List<i12.TvShow>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends i1.Mock
    implements i14.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<List<i15.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<i15.MovieModel>>.value(<i15.MovieModel>[]))
          as i7.Future<List<i15.MovieModel>>);
  @override
  i7.Future<List<i15.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<i15.MovieModel>>.value(<i15.MovieModel>[]))
      as i7.Future<List<i15.MovieModel>>);
  @override
  i7.Future<List<i15.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<i15.MovieModel>>.value(<i15.MovieModel>[]))
      as i7.Future<List<i15.MovieModel>>);
  @override
  i7.Future<i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as i7.Future<i3.MovieDetailResponse>);
  @override
  i7.Future<List<i15.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<i15.MovieModel>>.value(<i15.MovieModel>[]))
          as i7.Future<List<i15.MovieModel>>);
  @override
  i7.Future<List<i15.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<i15.MovieModel>>.value(<i15.MovieModel>[]))
          as i7.Future<List<i15.MovieModel>>);
}

/// A class which mocks [TVShowRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVShowRemoteDataSource extends i1.Mock
    implements i16.TvRemoteDataSource {
  MockTVShowRemoteDataSource() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<List<i17.TvModel>> getNowPlayingTv() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTVShows, []),
              returnValue:
                  Future<List<i17.TvModel>>.value(<i17.TvModel>[]))
          as i7.Future<List<i17.TvModel>>);
  @override
  i7.Future<List<i17.TvModel>> getPopularTv() =>
      (super.noSuchMethod(Invocation.method(#getPopularTVShows, []),
              returnValue:
                  Future<List<i17.TvModel>>.value(<i17.TvModel>[]))
          as i7.Future<List<i17.TvModel>>);
  @override
  i7.Future<List<i17.TvModel>> getTopRatedTv() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTVShows, []),
              returnValue:
                  Future<List<i17.TvModel>>.value(<i17.TvModel>[]))
          as i7.Future<List<i17.TvModel>>);
  @override
  i7.Future<i4.TvDetailResponse> getTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVShowDetail, [id]),
              returnValue: Future<i4.TvDetailResponse>.value(
                  _FakeTVShowDetailResponse_2()))
          as i7.Future<i4.TvDetailResponse>);
  @override
  i7.Future<List<i17.TvModel>> getTvRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVShowRecommendations, [id]),
              returnValue:
                  Future<List<i17.TvModel>>.value(<i17.TvModel>[]))
          as i7.Future<List<i17.TvModel>>);
  @override
  i7.Future<List<i17.TvModel>> searchTv(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTVShows, [query]),
              returnValue:
                  Future<List<i17.TvModel>>.value(<i17.TvModel>[]))
          as i7.Future<List<i17.TvModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends i1.Mock
    implements i18.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<String> insertWatchlist(i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as i7.Future<String>);
  @override
  i7.Future<String> removeWatchlist(i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as i7.Future<String>);
  @override
  i7.Future<i19.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<i19.MovieTable?>.value())
          as i7.Future<i19.MovieTable?>);
  @override
  i7.Future<List<i19.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<i19.MovieTable>>.value(<i19.MovieTable>[]))
      as i7.Future<List<i19.MovieTable>>);
}

/// A class which mocks [TVShowLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVShowLocalDataSource extends i1.Mock
    implements i20.TvLocalDataSource {
  MockTVShowLocalDataSource() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<String> insertWatchlistTv(i21.TvTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tvShow]),
          returnValue: Future<String>.value('')) as i7.Future<String>);
  @override
  i7.Future<String> removeWatchlistTv(i21.TvTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvShow]),
          returnValue: Future<String>.value('')) as i7.Future<String>);
  @override
  i7.Future<i21.TvTable?> getTVShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVShowById, [id]),
              returnValue: Future<i21.TvTable?>.value())
          as i7.Future<i21.TvTable?>);
  @override
  i7.Future<List<i21.TvTable>> getWatchlistTv() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTVShows, []),
              returnValue:
                  Future<List<i21.TvTable>>.value(<i21.TvTable>[]))
          as i7.Future<List<i21.TvTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends i1.Mock implements i22.DatabaseHelper {
  MockDatabaseHelper() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<i23.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<i23.Database?>.value())
          as i7.Future<i23.Database?>);
  @override
  i7.Future<int> insertMovieWatchlist(i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertMovieWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as i7.Future<int>);
  @override
  i7.Future<int> insertTVShowWatchlist(i21.TvTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertTVShowWatchlist, [tvShow]),
          returnValue: Future<int>.value(0)) as i7.Future<int>);
  @override
  i7.Future<int> removeMovieWatchlist(i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeMovieWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as i7.Future<int>);
  @override
  i7.Future<int> removeTVShowWatchlist(i21.TvTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeTVShowWatchlist, [tvShow]),
          returnValue: Future<int>.value(0)) as i7.Future<int>);
  @override
  i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as i7.Future<Map<String, dynamic>?>);
  @override
  i7.Future<Map<String, dynamic>?> getTVShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVShowById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as i7.Future<Map<String, dynamic>?>);
  @override
  i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as i7.Future<List<Map<String, dynamic>>>);
  @override
  i7.Future<List<Map<String, dynamic>>> getWatchlistTVShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTVShows, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends i1.Mock implements i5.Client {
  MockHttpClient() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<i5.Response>.value(_FakeResponse_3()))
          as i7.Future<i5.Response>);
  @override
  i7.Future<i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<i5.Response>.value(_FakeResponse_3()))
          as i7.Future<i5.Response>);
  @override
  i7.Future<i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<i5.Response>.value(_FakeResponse_3()))
          as i7.Future<i5.Response>);
  @override
  i7.Future<i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<i5.Response>.value(_FakeResponse_3()))
          as i7.Future<i5.Response>);
  @override
  i7.Future<i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<i5.Response>.value(_FakeResponse_3()))
          as i7.Future<i5.Response>);
  @override
  i7.Future<i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<i5.Response>.value(_FakeResponse_3()))
          as i7.Future<i5.Response>);
  @override
  i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as i7.Future<String>);
  @override
  i7.Future<i25.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<i25.Uint8List>.value(i25.Uint8List(0)))
          as i7.Future<i25.Uint8List>);
  @override
  i7.Future<i5.StreamedResponse> send(i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<i5.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as i7.Future<i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}