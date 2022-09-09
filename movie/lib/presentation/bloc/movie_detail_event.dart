part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieDetail extends MovieDetailEvent {
  final int id;

  const OnFetchMovieDetail(this.id);
  
  @override
  List<Object> get props => [id];
}

class OnLoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  const OnLoadWatchlistStatus(this.id);
  
  @override
  List<Object> get props => [id];
}

class OnAddWatchlist extends MovieDetailEvent {
  final MovieDetail detail;

  const OnAddWatchlist(this.detail);
    
  @override
  List<Object> get props => [detail];
}

class OnRemoveWatchlist extends MovieDetailEvent {
  final MovieDetail detail;

  const OnRemoveWatchlist(this.detail);
  
  @override
  List<Object> get props => [detail];
}