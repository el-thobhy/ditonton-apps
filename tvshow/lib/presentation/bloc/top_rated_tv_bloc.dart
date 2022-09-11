import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:core/domain/usecases/tv_show/get_top_rated_tv_shows.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv _topRatedTvs;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap((mapper));
  }

  TopRatedTvBloc(this._topRatedTvs) : super(TopRatedTvEmpty()) {
    on<OnFetchTopRated>(((event, emit) async {
      emit(TopRatedTvLoading());
      final result = await _topRatedTvs.execute();

      result.fold(
          (failure) => emit(TopRatedTvError(failure.message)),
          (data) => data.isNotEmpty
              ? emit(TopRatedTvLoaded(data))
              : emit(TopRatedTvEmpty()));
    }), transformer: debounce(const Duration(milliseconds: 500)));
  }
}
