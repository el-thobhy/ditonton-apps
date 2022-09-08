import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/test/presentation/provider/movie_list_notifier_test.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';

@GenerateMocks([MovieModel])
void main() {
  late PopularMovieBloc popularBloc;
  late MockGetPopularMovies mockPopularMovies;

  setUp(() {
    mockPopularMovies = MockGetPopularMovies();
    popularBloc = PopularMovieBloc(mockPopularMovies);
  });

  test('initial state should be empty', () {
    expect(popularBloc.state, PopularMovieEmpty());
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

  group('Popular movie', () {
    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should emit Loading and Loaded when Popular is successfully',
      build: () {
        when(mockPopularMovies.execute())
            .thenAnswer((_) async => const Right(movieList));
        return popularBloc;
      },
      act: (bloc) => bloc.add(const OnFetchPopular()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularMovieLoading(),
        const PopularMovieLoaded(movieList),
      ],
      verify: (bloc) {
        verify(mockPopularMovies.execute());
        return const OnFetchPopular().props;
      },
    );

    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should Emit Loading and error state when fail Popular',
      build: () {
        when(mockPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularBloc;
      },
      act: (bloc) => bloc.add(const OnFetchPopular()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularMovieLoading(),
        const PopularMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockPopularMovies.execute());
      },
    );

    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should Emit loading and Empty state when data Popular is empty',
      build: () {
        when(mockPopularMovies.execute()).thenAnswer(
            (_) async => const Right([]));
        return popularBloc;
      },
      act: (bloc) => bloc.add(const OnFetchPopular()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieEmpty(),
      ],
      verify: (bloc) {
        verify(mockPopularMovies.execute());
      },
    );
  });
}