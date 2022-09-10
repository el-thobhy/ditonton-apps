part of 'popular_movie_bloc.dart';

abstract class PopularMovieEvent extends Equatable {
  const PopularMovieEvent();

  @override
  List<Object> get props => [];
}

class OnFetchPopular extends PopularMovieEvent {
  const OnFetchPopular();

  @override
  List<Object> get props => [];
}