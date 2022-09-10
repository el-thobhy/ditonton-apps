import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tvshow/domain/usecases/tv_show/get_popular_tv_shows.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv _popularTvs;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap((mapper));
  }

  PopularTvBloc(this._popularTvs) : super(PopularTvEmpty()) {
    on<OnFetchPopular>(((event, emit) async {
      emit(PopularTvLoading());
      final result = await _popularTvs.execute();

      result.fold(
          (failure) => emit(PopularTvError(failure.message)),
          (data) => data.isNotEmpty
              ? emit(PopularTvLoaded(data))
              : emit(PopularTvEmpty()));
    }), transformer: debounce(const Duration(milliseconds: 500)));
  }
}
