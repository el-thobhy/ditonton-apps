part of 'tv_detail_bloc.dart';

@immutable
abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvDetail extends TvDetailEvent {
  final int id;

  const OnFetchTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnLoadWatchlistStatus extends TvDetailEvent {
  final int id;

  const OnLoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddWatchlist extends TvDetailEvent {
  final TvShowDetail detail;

  const OnAddWatchlist(this.detail);

  @override
  List<Object> get props => [detail];
}

class OnRemoveWatchlist extends TvDetailEvent {
  final TvShowDetail detail;

  const OnRemoveWatchlist(this.detail);

  @override
  List<Object> get props => [detail];
}
