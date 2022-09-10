part of 'tv_detail_bloc.dart';

@immutable
class TvDetailState extends Equatable {
  final TvShowDetail? detail;
  final List<TvShow> tvRecommendation;
  final RequestState detailState;
  final RequestState recommendationState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  const TvDetailState(
    this.detail,
    this.tvRecommendation,
    this.detailState,
    this.recommendationState,
    this.isAddedToWatchlist,
    this.message,
    this.watchlistMessage,
  );

  TvDetailState copyWith({
    TvShowDetail? detail,
    List<TvShow>? tvRecommendation,
    RequestState? detailState,
    RequestState? recommendationState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return TvDetailState(
      detail ?? this.detail,
      tvRecommendation ?? this.tvRecommendation,
      detailState ?? this.detailState,
      recommendationState ?? this.recommendationState,
      isAddedToWatchlist ?? this.isAddedToWatchlist,
      message ?? this.message,
      watchlistMessage ?? this.watchlistMessage,
    );
  }

  factory TvDetailState.initial() {
    return const TvDetailState(
      null,
      [],
      RequestState.empty,
      RequestState.empty,
      false,
      '',
      '',
    );
  }

  @override
  List<Object?> get props => [
        detail,
        tvRecommendation,
        detailState,
        recommendationState,
        isAddedToWatchlist,
        message,
        watchlistMessage,
      ];
}
