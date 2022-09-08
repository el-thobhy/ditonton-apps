import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/movie/get_popular_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc
    extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _popularMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap((mapper));
  }

  PopularMovieBloc(this._popularMovies) : super(PopularMovieEmpty()) {
    on<OnFetchPopular>(((event, emit) async {
      emit(PopularMovieLoading());
      final result = await _popularMovies.execute();

      result.fold(
          (failure) => emit(PopularMovieError(failure.message)),
          (data) => data.isNotEmpty
              ? emit(PopularMovieLoaded(data))
              : emit(PopularMovieEmpty()));
    }), transformer: debounce(const Duration(milliseconds: 500)));
  }
}