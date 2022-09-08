import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _nowPlayingMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap((mapper));
  }

  NowPlayingMovieBloc(this._nowPlayingMovies) : super(NowPlayingMovieEmpty()) {
    on<OnFetchNowPlaying>(((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await _nowPlayingMovies.execute();

      result.fold(
          (failure) => emit(NowPlayingMovieError(failure.message)),
          (data) => data.isNotEmpty
              ? emit(NowPlayingMovieLoaded(data))
              : emit(NowPlayingMovieEmpty()));
    }), transformer: debounce(const Duration(milliseconds: 500)));
  }
}
