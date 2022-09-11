import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc topRatedBloc;
  late MockGetTopRatedMovies mockTopRatedMovies;

  setUp(() {
    mockTopRatedMovies = MockGetTopRatedMovies();
    topRatedBloc = TopRatedMovieBloc(mockTopRatedMovies);
  });

  test('Initial state should be empty', () {
    expect(topRatedBloc.state, TopRatedMovieEmpty());
  });

  group('TopRated movie', () {
    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'Should Return Loading and Loaded when fetch data success',
      build: () {
        when(mockTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTopRated()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieLoaded(testMovieList),
      ],
      verify: (bloc) {
        verify(mockTopRatedMovies.execute());
        return const OnFetchTopRated().props;
      },
    );

    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'Should Return Loading and error state when fail fetch data',
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
      'Should Return loading and Empty state when data is empty',
      build: () {
        when(mockTopRatedMovies.execute())
            .thenAnswer((_) async => const Right([]));
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
