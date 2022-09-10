import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';

/// fake search movies bloc
class FakeSearchMoviesEvent extends Fake implements SearchMovieEvent {}

class FakeSearchMoviesState extends Fake implements SearchMovieState {}

class FakeSearchMoviesBloc extends MockBloc<SearchMovieEvent, SearchMovieState>
    implements SearchMovieBloc {}

/// fake search tv shows bloc
class FakeSearchTVShowsEvent extends Fake implements SearchTvEvent {}

class FakeSearchTVShowsState extends Fake implements SearchTvState {}

class FakeSearchTVShowsBloc extends MockBloc<SearchTvEvent, SearchTvState>
    implements SearchTvBloc {}
