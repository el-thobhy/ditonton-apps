import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/movie/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'pupular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularBloc;
  late MockGetPopularMovies mockPopularMovies;

  setUp(() {
    mockPopularMovies = MockGetPopularMovies();
    popularBloc = PopularMovieBloc(mockPopularMovies);
  });

  test('Initial state should be empty', () {
    expect(popularBloc.state, PopularMovieEmpty());
  });

  group('Popular movie', () {
    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should Return Loading and Loaded state when fetch data success',
      build: () {
        when(mockPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return popularBloc;
      },
      act: (bloc) => bloc.add(const OnFetchPopular()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieLoaded(testMovieList),
      ],
      verify: (bloc) {
        verify(mockPopularMovies.execute());
        return const OnFetchPopular().props;
      },
    );

    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should return Loading and error state when fail fetch data',
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
      'Should return loading and Empty state when data is empty',
      build: () {
        when(mockPopularMovies.execute())
            .thenAnswer((_) async => const Right([]));
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
