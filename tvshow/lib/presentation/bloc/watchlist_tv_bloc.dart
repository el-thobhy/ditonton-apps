import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tvshow/domain/usecases/tv_show/get_watchlist_tv_shows.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv _getWatchlistTvs;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  WatchlistTvBloc(this._getWatchlistTvs) : super(WatchlistTvEmpty()) {
    on<OnFetchWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await _getWatchlistTvs.execute();

      result.fold(
        (failure) {
          emit(WatchlistTvError(failure.message));
        },
        (data) {
          data.isEmpty
              ? emit(WatchlistTvEmpty())
              : emit(WatchlistTvLoaded(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
