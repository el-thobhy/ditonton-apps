import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _topRatedMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap((mapper));
  }

  TopRatedMovieBloc(this._topRatedMovies) : super(TopRatedMovieEmpty()) {
    on<OnFetchTopRated>(((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await _topRatedMovies.execute();

      result.fold(
          (failure) => emit(TopRatedMovieError(failure.message)),
          (data) => data.isNotEmpty
              ? emit(TopRatedMovieLoaded(data))
              : emit(TopRatedMovieEmpty()));
    }), transformer: debounce(const Duration(milliseconds: 500)));
  }
}
