import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistBloc;
  late MockGetWatchlistMovies mockWatchlistMovies;

  setUp(() {
    mockWatchlistMovies = MockGetWatchlistMovies();
    watchlistBloc = WatchlistMovieBloc(mockWatchlistMovies);
  });

  test('Initial state should be empty', () {
    expect(watchlistBloc.state, WatchlistMovieEmpty());
  });

  group('Watchlist movie', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should Return Loading and Loaded when fetch data success',
      build: () {
        when(mockWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieLoaded(testMovieList),
      ],
      verify: (bloc) {
        verify(mockWatchlistMovies.execute());
        return OnFetchWatchlistMovie().props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should return Loading and error state when fail fetch data',
      build: () {
        when(mockWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistMovieLoading(),
        const WatchlistMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should return loading and Empty state when data is empty',
      build: () {
        when(mockWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieEmpty(),
      ],
      verify: (bloc) {
        verify(mockWatchlistMovies.execute());
      },
    );
  });
}
