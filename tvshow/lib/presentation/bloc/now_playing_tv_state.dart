part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvEmpty extends NowPlayingTvState {}

class NowPlayingTvLoading extends NowPlayingTvState {}

class NowPlayingTvError extends NowPlayingTvState {
  final String message;

  const NowPlayingTvError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvLoaded extends NowPlayingTvState {
  final List<TvShow> result;

  const NowPlayingTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
