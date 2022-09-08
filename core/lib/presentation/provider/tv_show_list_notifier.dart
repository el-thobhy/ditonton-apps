import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:movie/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
import 'package:movie/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:movie/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:flutter/foundation.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTVShows = <TvShow>[];
  List<TvShow> get nowPlayingTVShows => _nowPlayingTVShows;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTVShows = <TvShow>[];
  List<TvShow> get popularTVShows => _popularTVShows;

  RequestState _popularTVShowsState = RequestState.empty;
  RequestState get popularTVShowsState => _popularTVShowsState;

  var _topRatedTVShows = <TvShow>[];
  List<TvShow> get topRatedTVShows => _topRatedTVShows;

  RequestState _topRatedTVShowsState = RequestState.empty;
  RequestState get topRatedTVShowsState => _topRatedTVShowsState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTVShows,
    required this.getPopularTVShows,
    required this.getTopRatedTVShows,
  });

  final GetNowPlayingTv getNowPlayingTVShows;
  final GetPopularTv getPopularTVShows;
  final GetTopRatedTv getTopRatedTVShows;

  Future<void> fetchNowPlayingTv() async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTVShows.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _nowPlayingState = RequestState.loaded;
        _nowPlayingTVShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTVShowsState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTVShows.execute();
    result.fold(
      (failure) {
        _popularTVShowsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _popularTVShowsState = RequestState.loaded;
        _popularTVShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTVShowsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTVShows.execute();
    result.fold(
      (failure) {
        _topRatedTVShowsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _topRatedTVShowsState = RequestState.loaded;
        _topRatedTVShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
