
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';

import '../../helper/movie_list_bloc_test.mocks.dart';

@GenerateMocks([MovieModel])
void main() {
  late TopRatedMovieBloc topRatedBloc;
  late MockGetTopRatedMovies mockTopRatedMovies;

  setUp(() {
    mockTopRatedMovies = MockGetTopRatedMovies();
    topRatedBloc = TopRatedMovieBloc(mockTopRatedMovies);
  });

  test('initial state should be empty', () {
    expect(topRatedBloc.state, TopRatedMovieEmpty());
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

  group('TopRated movie', () {
    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'Should emit Loading and Loaded when TopRated is successfully',
      build: () {
        when(mockTopRatedMovies.execute())
            .thenAnswer((_) async => const Right(movieList));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTopRated()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedMovieLoading(),
        const TopRatedMovieLoaded(movieList),
      ],
      verify: (bloc) {
        verify(mockTopRatedMovies.execute());
        return const OnFetchTopRated().props;
      },
    );

    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'Should Emit Loading and error state when fail TopRated',
      build: () {
        when(mockTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTopRated()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedMovieLoading(),
        const TopRatedMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'Should Emit loading and Empty state when data TopRated is empty',
      build: () {
        when(mockTopRatedMovies.execute()).thenAnswer(
            (_) async => const Right([]));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTopRated()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieEmpty(),
      ],
      verify: (bloc) {
        verify(mockTopRatedMovies.execute());
      },
    );
  });
}