import 'package:ditonton_apps/common/state_enum.dart';
import 'package:ditonton_apps/domain/entities/tv_show.dart';
import 'package:ditonton_apps/domain/entities/tv_show_detail.dart';
import 'package:ditonton_apps/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:ditonton_apps/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:ditonton_apps/domain/usecases/tv_show/get_watchlist_status_tv_show.dart';
import 'package:ditonton_apps/domain/usecases/tv_show/remove_watchlist.dart';
import 'package:ditonton_apps/domain/usecases/tv_show/save_watchlist.dart';
import 'package:flutter/foundation.dart';

class TvDetailNotifier extends ChangeNotifier {
  TvDetailNotifier({
    required this.getTVShowDetail,
    required this.getTVShowRecommendations,
    required this.getWatchListStatusTVShow,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  final GetTvDetail getTVShowDetail;
  final GetTvRecommendations getTVShowRecommendations;
  final GetWatchListStatusTv getWatchListStatusTVShow;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  late TvShowDetail _tvShowDetail;
  TvShowDetail get tvShowDetail => _tvShowDetail;

  RequestState _tvShowState = RequestState.empty;
  RequestState get tvShowState => _tvShowState;

  List<TvShow> _tvShowRecommendations = [];
  List<TvShow> get tvShowRecommendations => _tvShowRecommendations;

  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTVShowDetail(int id) async {
    _tvShowState = RequestState.loading;
    notifyListeners();

    final detailResult = await getTVShowDetail.execute(id);
    final recommendationResult = await getTVShowRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvShowState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShow) {
        _recommendationState = RequestState.loading;
        _tvShowDetail = tvShow;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (tvShows) {
            _recommendationState = RequestState.loaded;
            _tvShowRecommendations = tvShows;
          },
        );
        _tvShowState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvShowDetail tvShow) async {
    final result = await saveWatchlist.execute(tvShow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> removeFromWatchlist(TvShowDetail tvShow) async {
    final result = await removeWatchlist.execute(tvShow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTVShow.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
