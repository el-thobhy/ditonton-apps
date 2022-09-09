part of 'movie_detail_bloc.dart';

@immutable
class MovieDetailState extends Equatable {
  final MovieDetail? detail;
  final List<Movie> movieRecommendation;
  final RequestState detailState;
  final RequestState recommendationState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  const MovieDetailState(
    this.detail,
    this.movieRecommendation,
    this.detailState,
    this.recommendationState,
    this.isAddedToWatchlist,
    this.message,
    this.watchlistMessage,
  );

  MovieDetailState copyWith({
    MovieDetail? detail,
    List<Movie>? movieRecommendation,
    RequestState? detailState,
    RequestState? recommendationState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return MovieDetailState(
      detail ?? this.detail,
      movieRecommendation ?? this.movieRecommendation,
      detailState ?? this.detailState,
      recommendationState ?? this.recommendationState,
      isAddedToWatchlist ?? this.isAddedToWatchlist,
      message ?? this.message,
      watchlistMessage ?? this.watchlistMessage,
    );
  }

  factory MovieDetailState.initial() {
    return const MovieDetailState(
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
        movieRecommendation,
        detailState,
        recommendationState,
        isAddedToWatchlist,
        message,
        watchlistMessage,
      ];
}
