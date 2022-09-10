import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/presentation/bloc/movie/search_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = SearchMovieBloc(mockSearchMovies);
  });

  test('Initial state should be empty', () {
    expect(searchBloc.state, SearchMovieEmpty());
  });

  const query = 'spiderman';

  group('Search movie', () {
    blocTest<SearchMovieBloc, SearchMovieState>(
      'Should return Loading and Loaded state when Search success',
      build: () {
        when(mockSearchMovies.execute(query))
            .thenAnswer((_) async => Right(testMovieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryMovieChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        SearchMovieLoaded(testMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(query));
        return const OnQueryMovieChanged(query).props;
      },
    );

    blocTest<SearchMovieBloc, SearchMovieState>(
      'Should Return Loading and error state when fail',
      build: () {
        when(mockSearchMovies.execute(query)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryMovieChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        const SearchMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(query));
      },
    );

    blocTest<SearchMovieBloc, SearchMovieState>(
      'Should return loading and Empty state when data search is empty',
      build: () {
        when(mockSearchMovies.execute(query))
            .thenAnswer((_) async => const Right([]));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryMovieChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        SearchMovieEmpty(),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(query));
      },
    );
  });
}
