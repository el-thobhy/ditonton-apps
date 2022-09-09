import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/test/presentation/bloc/search_notifier_test.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/presentation/bloc/movie/search_movie_bloc.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = SearchMovieBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchMovieEmpty());
  });

  const movieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  const movieList = [movieModel];
  const query = 'spiderman';

  group('Search movie', () {
    blocTest<SearchMovieBloc, SearchMovieState>(
      'Should emit Loading and Loaded when Search is successfully',
      build: () {
        when(mockSearchMovies.execute(query))
            .thenAnswer((_) async => const Right(movieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryMovieChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        const SearchMovieLoaded(movieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(query));
        return const OnQueryMovieChanged(query).props;
      },
    );

    blocTest<SearchMovieBloc, SearchMovieState>(
      'Should Emit Loading and error state when fail search',
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
      'Should Emit loading and Empty state when data search is empty',
      build: () {
        when(mockSearchMovies.execute(query)).thenAnswer(
            (_) async => const Right([]));
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
