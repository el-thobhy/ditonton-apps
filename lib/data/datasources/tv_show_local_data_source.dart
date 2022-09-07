import 'package:ditonton_apps/common/exception.dart';
import 'package:ditonton_apps/data/datasources/db/database_helper.dart';
import 'package:ditonton_apps/data/models/tv_show_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTv(TvTable tvShow);
  Future<String> removeWatchlistTv(TvTable tvShow);
  Future<TvTable?> getTVShowById(int id);
  Future<List<TvTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvTable?> getTVShowById(int id) async {
    final result = await databaseHelper.getTVShowById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTVShows();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlistTv(TvTable tvShow) async {
    try {
      await databaseHelper.insertTVShowWatchlist(tvShow);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvTable tvShow) async {
    try {
      await databaseHelper.removeTVShowWatchlist(tvShow);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
