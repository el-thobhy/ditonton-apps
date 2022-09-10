import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/search.dart';

part 'search_movie_state.dart';
part 'search_movie_event.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap((mapper));
  }

  SearchMovieBloc(this._searchMovies) : super(SearchMovieEmpty()) {
    on<OnQueryMovieChanged>(((event, emit) async {
      final query = event.query;

      emit(SearchMovieLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
          (failure) => emit(SearchMovieError(failure.message)),
          (data) => data.isNotEmpty
              ? emit(SearchMovieLoaded(data))
              : emit(SearchMovieEmpty()));
    }), transformer: debounce(const Duration(milliseconds: 500)));
  }
}
