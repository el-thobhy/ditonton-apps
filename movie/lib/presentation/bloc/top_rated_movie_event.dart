part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieEvent extends Equatable {
  const TopRatedMovieEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTopRated extends TopRatedMovieEvent {
  const OnFetchTopRated();

  @override
  List<Object> get props => [];
}