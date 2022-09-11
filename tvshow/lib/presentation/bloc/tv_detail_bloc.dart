import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:core/domain/usecases/tv_show/get_watchlist_status_tv_show.dart';
import 'package:core/domain/usecases/tv_show/remove_watchlist.dart';
import 'package:core/domain/usecases/tv_show/save_watchlist.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatusTv getWatchListStatusTv;

  TvDetailBloc(
    this.getTvDetail,
    this.getTvRecommendations,
    this.saveWatchlist,
    this.removeWatchlist,
    this.getWatchListStatusTv,
  ) : super(TvDetailState.initial()) {
    on<OnFetchTvDetail>(
      ((event, emit) async {
        emit(state.copyWith(detailState: RequestState.loading));

        final detail = await getTvDetail.execute(event.id);
        final recomendation = await getTvRecommendations.execute(event.id);

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
              tvRecommendation: data,
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
        final result = await getWatchListStatusTv.execute(event.id);
        emit(state.copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
