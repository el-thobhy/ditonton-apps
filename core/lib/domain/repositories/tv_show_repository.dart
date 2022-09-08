import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TvShow>>> getNowPlayingTv();
  Future<Either<Failure, List<TvShow>>> getPopularTv();
  Future<Either<Failure, List<TvShow>>> getTopRatedTv();
  Future<Either<Failure, TvShowDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TvShow>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TvShow>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlist(TvShowDetail tvShow);
  Future<Either<Failure, String>> removeWatchlist(TvShowDetail tvShow);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvShow>>> getWatchlistTv();
}
