import 'dart:io';

import 'package:ditonton_apps/common/exception.dart';
import 'package:ditonton_apps/data/datasources/tv_show_local_data_source.dart';
import 'package:ditonton_apps/data/datasources/tv_show_remote_data_source.dart';
import 'package:ditonton_apps/data/models/tv_show_table.dart';
import 'package:ditonton_apps/domain/entities/tv_show_detail.dart';
import 'package:ditonton_apps/domain/entities/tv_show.dart';
import 'package:ditonton_apps/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton_apps/domain/repositories/tv_show_repository.dart';

class TVShowRepositoryImpl implements TvRepository {
  TVShowRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<TvShow>>> getNowPlayingTv() async {
    try {
      final result = await remoteDataSource.getNowPlayingTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getPopularTv() async {
    try {
      final result = await remoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvShowDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTopRatedTv() async {
    try {
      final result = await remoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getWatchlistTv() async {
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTVShowById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvShowDetail tvShow) async {
    try {
      final result =
          await localDataSource.removeWatchlistTv(TvTable.fromEntity(tvShow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvShowDetail tvShow) async {
    try {
      final result =
          await localDataSource.insertWatchlistTv(TvTable.fromEntity(tvShow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }
}
