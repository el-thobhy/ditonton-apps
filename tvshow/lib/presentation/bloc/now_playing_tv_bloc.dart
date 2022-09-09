import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tvshow/domain/usecases/tv_show/get_now_playing_tv_shows.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc
    extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTv _nowPlayingTvs;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap((mapper));
  }

  NowPlayingTvBloc(this._nowPlayingTvs) : super(NowPlayingTvEmpty()) {
    on<OnFetchNowPlaying>(((event, emit) async {
      emit(NowPlayingTvLoading());
      final result = await _nowPlayingTvs.execute();

      result.fold(
          (failure) => emit(NowPlayingTvError(failure.message)),
          (data) => data.isNotEmpty
              ? emit(NowPlayingTvLoaded(data))
              : emit(NowPlayingTvEmpty()));
    }), transformer: debounce(const Duration(milliseconds: 500)));
  }
}
