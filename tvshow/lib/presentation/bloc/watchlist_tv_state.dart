part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();
  
   @override
  List<Object?> get props => [];
}
 
class WatchlistTvEmpty extends WatchlistTvState {}
 
class WatchlistTvLoading extends WatchlistTvState {}
 
class WatchlistTvError extends WatchlistTvState {
  final String message;
 
  const WatchlistTvError(this.message);
 
  @override
  List<Object?> get props => [message];
}
 
class WatchlistTvLoaded extends WatchlistTvState {
  final List<TvShow> result;
 
  const WatchlistTvLoaded(this.result);
 
  @override
  List<Object?> get props => [result];
}