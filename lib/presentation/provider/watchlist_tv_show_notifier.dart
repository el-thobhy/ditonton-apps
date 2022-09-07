import 'package:ditonton_apps/common/state_enum.dart';
import 'package:ditonton_apps/domain/entities/tv_show.dart';
import 'package:ditonton_apps/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTv = <TvShow>[];
  List<TvShow> get watchlistTv => _watchlistTv;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlistTv});

  final GetWatchlistTv getWatchlistTv;

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _watchlistState = RequestState.loaded;
        _watchlistTv = tvShowsData;
        notifyListeners();
      },
    );
  }
}
