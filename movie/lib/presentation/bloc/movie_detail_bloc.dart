import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/movie/get_movie_detail.dart';
import 'package:movie/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/movie/get_watchlist_status_movie.dart';
import 'package:movie/domain/usecases/movie/remove_watchlist.dart';
import 'package:movie/domain/usecases/movie/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatusMovie getWatchListStatusMovie;

  MovieDetailBloc(
    this.getMovieDetail,
    this.getMovieRecommendations,
    this.saveWatchlist,
    this.removeWatchlist,
    this.getWatchListStatusMovie,
  ) : super(MovieDetailState.initial()) {
    on<OnFetchMovieDetail>(
      ((event, emit) async {
        emit(state.copyWith(detailState: RequestState.loading));

        final detail = await getMovieDetail.execute(event.id);
        final recomendation = await getMovieRecommendations.execute(event.id);

        detail.fold(
          (failure) => emit(state.copyWith(detailState: RequestState.error)),
          (data) => emit(
            state.copyWith(
              detailState: RequestState.loaded,
              detail: data,
              recommendationState: RequestState.loading,
              message: '',
            ),
          ),
        );
        recomendation.fold(
          (fail) =>
              emit(state.copyWith(recommendationState: RequestState.error)),
          (data) => emit(
            state.copyWith(
              recommendationState: RequestState.loaded,
              movieRecommendation: data,
              message: '',
            ),
          ),
        );
      }),
    );

    on<OnAddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.detail);

      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );

      add(OnLoadWatchlistStatus(event.detail.id));
    });

    on<OnRemoveWatchlist>(
      (event, emit) async {
        final result = await removeWatchlist.execute(event.detail);

        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (successMessage) {
            emit(state.copyWith(watchlistMessage: successMessage));
          },
        );

        add(OnLoadWatchlistStatus(event.detail.id));
      },
    );

    on<OnLoadWatchlistStatus>(
      (event, emit) async {
        final result = await getWatchListStatusMovie.execute(event.id);
        emit(state.copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
