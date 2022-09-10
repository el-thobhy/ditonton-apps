import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';

part 'search_tv_state.dart';
part 'search_tv_event.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv _searchTvs;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap((mapper));
  }

  SearchTvBloc(this._searchTvs) : super(SearchTvEmpty()) {
    on<OnQueryTvChanged>(((event, emit) async {
      final query = event.query;

      emit(SearchTvLoading());
      final result = await _searchTvs.execute(query);

      result.fold(
          (failure) => emit(SearchTvError(failure.message)),
          (data) => data.isNotEmpty
              ? emit(SearchTvLoaded(data))
              : emit(SearchTvEmpty()));
    }), transformer: debounce(const Duration(milliseconds: 500)));
  }
}
