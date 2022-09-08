import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvNotifier({required this.getTopRatedTv});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvShow> _tvShows = [];
  List<TvShow> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
